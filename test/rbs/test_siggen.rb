# frozen_string_literal: true

require "test_helper"

module RBS
  class TestSiggen < Minitest::Test
    def test_generate
      ruby_string = <<~RUBY
        class A
          foo :bar
          foo :baz
        end
      RUBY
      sig_string = <<~SIG
        class A
          %a{siggen:
            def self.<%= name %>: () -> void
          }
          def self.foo: (Symbol name) -> void
        end
      SIG
      expected = <<~SIGGEN
        class A
          def self.bar: () -> void

          def self.baz: () -> void
        end
      SIGGEN
      siggen = RBS::Siggen.new
      siggen.add_signature(sig_string)
      siggen.analyze_ruby(ruby_string)

      assert_equal expected, siggen.generate
    end

    def test_generate_with_namespace
      ruby_string = <<~RUBY
        module M
          class A
            foo :bar
            foo :baz
          end
        end
      RUBY
      sig_string = <<~SIG
        module M
          class A
            %a{siggen:
              def self.<%= name %>: () -> void
            }
            def self.foo: (Symbol name) -> void
          end
        end
      SIG
      expected = <<~SIGGEN
        class M::A
          def self.bar: () -> void

          def self.baz: () -> void
        end
      SIGGEN
      siggen = RBS::Siggen.new
      siggen.add_signature(sig_string)
      siggen.analyze_ruby(ruby_string)

      assert_equal expected, siggen.generate
    end

    def test_nesting
      ruby_string = <<~RUBY
        A.define do
          create_table "articles" do |t|
            t.text "body"
            t.text "comment"
          end
        end
      RUBY
      sig_string = <<~SIG
        class A
          def self.define: () { () [self: instance] -> void } -> void
          def create_table: (String name) { (A) -> void } -> void

          %a{siggen:
            class <%= create_table.name.classify %>
              def <%= name %>: () -> String
            end
          }
          def text: (String name) -> void
        end
      SIG
      expected = <<~SIGGEN
        class Article
          def body: () -> String

          def comment: () -> String
        end
      SIGGEN
      siggen = RBS::Siggen.new
      siggen.add_signature(sig_string)
      siggen.analyze_ruby(ruby_string)

      assert_equal expected, siggen.generate
    end

    def test_comment_only_ruby_code
      ruby_string = <<~RUBY
        # class A
        #   foo :bar
        #   foo :baz
        # end
      RUBY
      sig_string = <<~SIG
        class A
          def foo: (Symbol name) -> void
        end
      SIG
      expected = ""
      siggen = RBS::Siggen.new
      siggen.add_signature(sig_string)
      siggen.analyze_ruby(ruby_string)

      assert_equal expected, siggen.generate
    end

    def test_reference_keyword_args
      ruby_string = <<~RUBY
        class A
          foo :bar, baz: true, qux: 123, quux: "aaa"
        end
      RUBY
      sig_string = <<~SIG
        class A
          %a{siggen:
            # baz     = <%= baz %>
            # qux     = <%= qux %>
            # options = <%= options.to_json %>
            def self.<%= name %>: () -> void
          }
          def self.foo: (Symbol name, baz: bool, ?qux: Integer, **untyped options) -> void
        end
      SIG
      expected = <<~SIGGEN
        class A
          # baz     = true
          # qux     = 123
          # options = {"quux":"aaa"}
          def self.bar: () -> void
        end
      SIGGEN
      siggen = RBS::Siggen.new
      siggen.add_signature(sig_string)
      siggen.analyze_ruby(ruby_string)

      assert_equal expected, siggen.generate
    end

    def test_inheritance
      ruby_string = <<~RUBY
        class A < S
          A.foo :bar
        end
        class B < S
          foo :baz
        end
      RUBY
      sig_string = <<~SIG
        class S
          %a{siggen:
            def self.<%= name %>: () -> void
          }
          def self.foo: (Symbol name) -> void
        end
        class A < S
        end
        class B < S
        end
      SIG
      expected = <<~SIGGEN
        class A
          def self.bar: () -> void
        end
        class B
          def self.baz: () -> void
        end
      SIGGEN
      siggen = RBS::Siggen.new
      siggen.add_signature(sig_string)
      siggen.analyze_ruby(ruby_string)

      assert_equal expected, siggen.generate
    end

    def test_block_variable
      ruby_string = <<~RUBY
        Schema.build do
          create_table "articles" do |t|
            t.text "body", null: false
            t.text "title"
            t.integer "views"
          end
        end
      RUBY
      sig_string = <<~SIG
        class Schema
          def self.build: () { () [self: instance] -> void } -> void

          %a{siggen:
            class <%= table_name.classify %>
              <% ___block.t.each do |col, arg| %>
                def <%= arg.name %>: () -> untyped
              <% end %>
            end
          }
          def create_table: (String table_name, **untyped options)
                            { (T t) -> void } -> void
        end

        class T
          def text: (String name, **untyped options) -> void
          def integer: (String name, **untyped options) -> void
        end
      SIG
      expected = <<~SIGGEN
        class Article
          def body: () -> untyped

          def title: () -> untyped

          def views: () -> untyped
        end
      SIGGEN
      siggen = RBS::Siggen.new
      siggen.add_signature(sig_string)
      siggen.analyze_ruby(ruby_string)

      assert_equal expected, siggen.generate
    end

    def test_block_variable_uses_method_name
      ruby_string = <<~RUBY
        Schema.build do
          create_table "articles" do |t|
            t.text "body", null: false
            t.text "title"
            t.integer "views"
          end
        end
      RUBY
      sig_string = <<~SIG
        class Schema
          def self.build: () { () [self: instance] -> void } -> void

          %a{siggen:
            class <%= table_name.classify %>
              <% ___block.t.each do |col, arg| %>
                # type: <%= col %>
                def <%= arg.name %>: () -> untyped
              <% end %>
            end
          }
          def create_table: (String table_name, **untyped options)
                            { (T t) -> void } -> void
        end

        class T
          def text: (String name, **untyped options) -> void
          def integer: (String name, **untyped options) -> void
        end
      SIG
      expected = <<~SIGGEN
        class Article
          # type: text
          def body: () -> untyped

          # type: text
          def title: () -> untyped

          # type: integer
          def views: () -> untyped
        end
      SIGGEN
      siggen = RBS::Siggen.new
      siggen.add_signature(sig_string)
      siggen.analyze_ruby(ruby_string)

      assert_equal expected, siggen.generate
    end

    def test_block_variable_same_method_multiple_times
      ruby_string = <<~RUBY
        Schema.build do
          create_table "articles" do |t|
            t.text "body"
            t.text "title"
          end
        end
      RUBY
      sig_string = <<~SIG
        class Schema
          def self.build: () { () [self: instance] -> void } -> void

          %a{siggen:
            class <%= table_name.classify %>
              <% ___block.t.each do |col, arg| %>
                def <%= arg.name %>: () -> String
              <% end %>
            end
          }
          def create_table: (String table_name, **untyped options)
                            { (T t) -> void } -> void
        end

        class T
          def text: (String name, **untyped options) -> void
        end
      SIG
      expected = <<~SIGGEN
        class Article
          def body: () -> String

          def title: () -> String
        end
      SIGGEN
      siggen = RBS::Siggen.new
      siggen.add_signature(sig_string)
      siggen.analyze_ruby(ruby_string)

      assert_equal expected, siggen.generate
    end

    def test_block_variable_keyword_args
      ruby_string = <<~RUBY
        Schema.build do
          create_table "articles" do |t|
            t.text "body", null: false
            t.text "title"
          end
        end
      RUBY
      sig_string = <<~SIG
        class Schema
          def self.build: () { () [self: instance] -> void } -> void

          %a{siggen:
            class <%= table_name.classify %>
              <% ___block.t.each do |col, arg| %>
                def <%= arg.name %>: () -> <%= arg.options[:null] == false ? "String" : "String?" %>
              <% end %>
            end
          }
          def create_table: (String table_name, **untyped options)
                            { (T t) -> void } -> void
        end

        class T
          def text: (String name, **untyped options) -> void
        end
      SIG
      expected = <<~SIGGEN
        class Article
          def body: () -> String

          def title: () -> String?
        end
      SIGGEN
      siggen = RBS::Siggen.new
      siggen.add_signature(sig_string)
      siggen.analyze_ruby(ruby_string)

      assert_equal expected, siggen.generate
    end

    def test_external_file_annotation
      require "tmpdir"
      Dir.mktmpdir do |dir|
        File.write(File.join(dir, "tmpl.rbs.erb"), <<~ERB)
          class A
            <%- hash = { result: type } -%>
            def self.<%= name %>: () -> <%= hash[:result] %>
          end
        ERB

        ruby_string = <<~RUBY
          class A
            foo :bar
          end
        RUBY
        sig_string = <<~SIG
          class A
            %a{siggen:file(tmpl.rbs.erb):TYPE=String}
            def self.foo: (Symbol name) -> void
          end
        SIG
        expected = <<~SIGGEN
          class A
            def self.bar: () -> String
          end
        SIGGEN

        siggen = RBS::Siggen.new
        siggen.add_signature(sig_string, name: File.join(dir, "test.rbs"))
        siggen.analyze_ruby(ruby_string)

        assert_equal expected, siggen.generate
      end
    end

    def test_capturing_arguments
      ruby_string = <<~RUBY
        class A#{" "}
          def self.m(a, b)
            1
          end

          m(:sym1, [true, 1, "2", :three], key: :val, complicated_val: [:foo, [:bar, :baz], {foo: "fuga"}])
        end
      RUBY
      sig_string = <<~SIG
        class A
          %a{siggen:
            # <%= a.to_json %>
            # <%= h.to_json %>
            def generated_<%= a[0] %>: () -> void
          }
          def self.m: (*untyped a, **untyped h) -> void
        end
      SIG
      expected = <<~SIGGEN
        class A
          # ["sym1",[true,1,"2","three"]]
          # {"key":"val","complicated_val":["foo",["bar","baz"],{"foo":"fuga"}]}
          def generated_sym1: () -> void
        end
      SIGGEN
      siggen = RBS::Siggen.new
      siggen.add_signature(sig_string)
      siggen.analyze_ruby(ruby_string)

      assert_equal expected, siggen.generate
    end
  end
end
