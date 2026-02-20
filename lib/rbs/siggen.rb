# frozen_string_literal: true

require "rbs"
require "steep"
require "parser"
require "erb"
require "stringio"
require_relative "siggen/version"

module RBS
  class Siggen # rubocop:disable Style/Documentation
    # @rbs @env: RBS::Environment
    # @rbs @typing: untyped
    # @rbs @node: Parser::AST::Node

    #: () ?{ (RBS::EnvironmentLoader) -> void } -> void
    def initialize
      core_root = RBS::EnvironmentLoader::DEFAULT_CORE_ROOT
      env_loader = RBS::EnvironmentLoader.new(core_root: core_root)
      yield env_loader if block_given?

      env = RBS::Environment.new
      env_loader.load(env: env)
      @env = env.resolve_type_names
    end

    #: (String sig_string, ?name: String) -> void
    def add_signature(sig_string, name: "a.rbs")
      buffer = RBS::Buffer.new(name:, content: sig_string)
      _, dirs, decls = RBS::Parser.parse_signature(buffer)
      @env.add_signature(buffer: buffer, directives: dirs, decls: decls)
    end

    #: (path: String) { (Siggen, String) -> void } -> void
    def analyze(path:)
      ruby_files = Dir.glob("#{path}/**/*.rb")
      ruby_files.each do |file|
        analyze_ruby(File.read(file), name: file)
        yield self, file
      end
    end

    #: (String ruby_string, ?name: String) -> void
    def analyze_ruby(ruby_string, name: "a.rb")
      # steep:ignore:start
      definition_builder = RBS::DefinitionBuilder.new(env: @env)

      factory = Steep::AST::Types::Factory.new(builder: definition_builder)
      builder = Steep::Interface::Builder.new(factory, implicitly_returns_nil: true)
      checker = Steep::Subtyping::Check.new(builder: builder)

      source = Steep::Source.parse(ruby_string, path: Pathname(name), factory: factory)

      annotations = source.annotations(block: source.node, factory: checker.factory, context: nil)
      resolver = RBS::Resolver::ConstantResolver.new(builder: checker.factory.definition_builder)
      const_env = Steep::TypeInference::ConstantEnv.new(factory: checker.factory, context: nil, resolver: resolver)

      case annotations.self_type
      when Steep::AST::Types::Name::Instance
        module_name = annotations.self_type.name
        module_type = Steep::AST::Types::Name::Singleton.new(name: module_name)
        instance_type = annotations.self_type
      when Steep::AST::Types::Name::Singleton
        module_name = annotations.self_type.name
        module_type = annotations.self_type
        instance_type = annotations.self_type
      else
        module_name = Steep::AST::Builtin::Object.module_name
        module_type = Steep::AST::Builtin::Object.module_type
        instance_type = Steep::AST::Builtin::Object.instance_type
      end

      type_env = Steep::TypeInference::TypeEnvBuilder.new(
        Steep::TypeInference::TypeEnvBuilder::Command::ImportGlobalDeclarations.new(checker.factory),
        Steep::TypeInference::TypeEnvBuilder::Command::ImportInstanceVariableAnnotations.new(annotations),
        Steep::TypeInference::TypeEnvBuilder::Command::ImportConstantAnnotations.new(annotations),
        Steep::TypeInference::TypeEnvBuilder::Command::ImportLocalVariableAnnotations.new(annotations)
      ).build(Steep::TypeInference::TypeEnv.new(const_env))

      context = Steep::TypeInference::Context.new(
        block_context: nil,
        method_context: nil,
        module_context: Steep::TypeInference::Context::ModuleContext.new(
          instance_type: instance_type,
          module_type: module_type,
          implement_name: nil,
          nesting: nil,
          class_name: module_name,
          instance_definition: checker.factory.definition_builder.build_instance(module_name),
          module_definition: checker.factory.definition_builder.build_singleton(module_name)
        ),
        break_context: nil,
        self_type: instance_type,
        type_env: type_env,
        call_context: Steep::TypeInference::MethodCall::TopLevelContext.new,
        variable_context: Steep::TypeInference::Context::TypeVariableContext.empty
      )

      typing = Steep::Typing.new(source: source, root_context: context, cursor: nil)
      construction = Steep::TypeConstruction.new(checker: checker,
                                                 source: source,
                                                 annotations: annotations,
                                                 context: context,
                                                 typing: typing)
      construction.synthesize(source.node)

      @typing = typing
      @node = source.node
      # steep:ignore:end
    end

    #: () -> String
    def generate
      io = ::StringIO.new
      traverse(@node) do |class_name, anno, arg_hash|
        generated = ERB.new(anno).result_with_hash(arg_hash)
        surround_class_def = false
        begin
          ::RBS::Parser.parse_signature(generated)
        rescue ::RBS::ParsingError => e
          surround_class_def = true if e.message =~ /Syntax error: cannot start a declaration/
        end

        io.puts "class #{class_name}" if surround_class_def
        io.puts generated
        io.puts "end" if surround_class_def
      end
      io.rewind
      _, _, decls = ::RBS::Parser.parse_signature(io.read || "")
      io = ::StringIO.new
      ::RBS::Writer.new(out: io).write(merge_class_declarations(decls))
      io.rewind
      io.readlines.reject { |line| line.strip.empty? }.join
    end

    #: (untyped node, ?Array[untyped] stack) ?{ (String, untyped, Hash[untyped, untyped]) -> void } -> void
    def traverse(node, stack = [], &block)
      return unless node.is_a?(::Parser::AST::Node)

      call_of = begin
        @typing.call_of(node:)
      rescue StandardError
        nil
      end

      if call_of.nil? ||
         call_of.is_a?(Steep::TypeInference::MethodCall::NoMethodError) || # steep:ignore
         call_of.is_a?(Steep::TypeInference::MethodCall::Untyped) # steep:ignore
        node.children.each do |child|
          traverse(child, stack, &block)
        end
      elsif %i[send block].include?(node.type) # steep:ignore
        call_of.method_decls.each do |method_decl|
          annos = method_decl.method_def
                             .member_annotations
                             .filter { |a| a.string.include?("siggen:") }
                             .map { |a| a.string.split("siggen:")[1].strip }
          next if annos.empty?

          arg_hash = {} #: Hash[untyped, untyped]
          stack.each do |n, c|
            arg_hash.merge!({ c.method_name.to_sym => hash_to_data(create_arg_hash(n, c.method_decls.first)) })
          end
          arg_hash.merge!(create_arg_hash(node, method_decl))

          annos.each { |anno| yield(create_class_name(method_decl), anno, arg_hash) }
        end

        if node.type == :block
          stack << [node, call_of]
          node.children.each do |child|
            traverse(child, stack, &block)
          end
          stack.pop
        end
      else # rubocop:disable Lint/DuplicateBranch
        node.children.each do |child|
          traverse(child, stack, &block)
        end
      end
    end

    #: (untyped) -> String
    def create_class_name(method_decl)
      receiver_type = method_decl.method_name.type_name.relative!
      "#{receiver_type.namespace}#{receiver_type.name}"
    end

    #: (untyped, untyped) -> Hash[untyped, untyped]
    def create_arg_hash(node, method_decl)
      send_node = node.type == :block ? node.children.first : node
      _, _, *args = send_node.children
      args = args.map { |a| a.children[0] }
      rp = method_decl.method_def.type.type.required_positionals.map(&:name)
      rp.zip(args).to_h
    end

    #: (Hash[untyped, untyped]) -> untyped
    def hash_to_data(hash)
      Data.define(*hash.keys).new(*hash.values)
    end

    #: (Array[untyped] -> Array[untyped])
    def merge_class_declarations(decls)
      # 同じ名前のClass宣言をグループ化
      grouped = decls.group_by do |decl|
        case decl
        when RBS::AST::Declarations::Class
          [:class,
           decl.name]
        when RBS::AST::Declarations::Module
          [:module,
           decl.name]
        else
          [:other, decl.object_id] # その他はマージしない
        end
      end

      grouped.map do |(kind, _name), group|
        if kind == :class && group.size > 1
          # 複数のClass宣言をマージ
          primary = group.find(&:super_class) || group.first
          merged_members = group.flat_map(&:members)
          merged_annotations = group.flat_map(&:annotations).uniq
          merged_comment = group.map(&:comment).compact.first

          RBS::AST::Declarations::Class.new(
            name: primary.name,
            type_params: primary.type_params,
            super_class: primary.super_class,
            members: merged_members,
            annotations: merged_annotations,
            location: primary.location,
            comment: merged_comment
          )
        elsif kind == :module && group.size > 1
          # 複数のModule宣言をマージ
          primary = group.first
          merged_members = group.flat_map(&:members)
          merged_annotations = group.flat_map(&:annotations).uniq
          merged_comment = group.map(&:comment).compact.first
          merged_self_types = group.flat_map(&:self_types).uniq

          RBS::AST::Declarations::Module.new(
            name: primary.name,
            type_params: primary.type_params,
            self_types: merged_self_types,
            members: merged_members,
            annotations: merged_annotations,
            location: primary.location,
            comment: merged_comment
          )
        else
          group
        end
      end.flatten
    end
  end
end
