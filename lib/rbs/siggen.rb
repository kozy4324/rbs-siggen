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

    #: (path: String) -> void
    def initialize(path: "sig")
      core_root = RBS::EnvironmentLoader::DEFAULT_CORE_ROOT
      env_loader = RBS::EnvironmentLoader.new(core_root: core_root)
      env_loader.add path: Pathname(path)

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
      result = {} #: Hash[String, Array[String]]

      traverse(@node) do |node, call_of|
        next unless node.type == :send

        _, _, *args = node.children
        args = args.map { |a| a.children[0] }

        call_of.method_decls.each do |method_decl|
          receiver_type = method_decl.method_name.type_name
          class_name = "#{receiver_type.namespace}#{receiver_type.name}"

          rp = method_decl.method_def.type.type.required_positionals.map(&:name)
          arg_hash = rp.zip(args).to_h
          annos = method_decl.method_def
                             .member_annotations
                             .filter { |a| a.string.include?("siggen:") }
                             .map { |a| a.string.split("siggen:")[1].strip }
          next if annos.empty?

          result[class_name] ||= []
          annos.each do |anno|
            result[class_name] << ERB.new(anno).result_with_hash(arg_hash)
          end
        end
      end

      io = ::StringIO.new
      result.each do |key, values|
        io.puts "class #{key}"
        values.each do |v|
          io.puts "  #{v}"
        end
        io.puts "end"
      end
      io.rewind
      io.read || ""
    end

    #: (untyped node) ?{ (Parser::AST::Node node, untyped call_of) -> void } -> void
    def traverse(node, &block)
      return unless node.is_a?(::Parser::AST::Node)

      call_of = begin
        @typing.call_of(node:)
      rescue StandardError
        nil
      end

      unless call_of.nil? || call_of.is_a?(Steep::TypeInference::MethodCall::NoMethodError) # steep:ignore
        yield(node, call_of)
      end

      node.children.each do |child|
        traverse(child, &block)
      end
    end
  end
end
