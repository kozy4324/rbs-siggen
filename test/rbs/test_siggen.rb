# frozen_string_literal: true

require "test_helper"

module RBS
  class TestSiggen < Minitest::Test
    def test_generate
      ruby_string = <<~RUBY
        class A
          foo :bar
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
        class ::A
          def self.bar: () -> void
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
          end
        end
      RUBY
      sig_string = <<~SIG
        class A
          def self.define: () { () [self: instance] -> void } -> void
          def create_table: (String name) { (A) -> void } -> void

          %a{siggen:
            class ::<%= create_table.name.classify %>
              def <%= name %>: () -> String
            end
          }
          def text: (String name) -> void
        end
      SIG
      expected = <<~SIGGEN
        class ::A
          class ::Article
            def body: () -> String
          end
        end
      SIGGEN
      siggen = RBS::Siggen.new
      siggen.add_signature(sig_string)
      siggen.analyze_ruby(ruby_string)

      assert_equal expected, siggen.generate
    end
  end
end
