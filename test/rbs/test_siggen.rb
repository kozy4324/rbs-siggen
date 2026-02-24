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

    def test_activerecord_schema
      ruby_string = <<~RUBY
        ActiveRecord::Schema[8.1].define(version: 2026_01_31_051626) do
          create_table "articles", force: :cascade do |t|
            t.text "body"
          end
        end
      RUBY
      sig_string = <<~SIG
        module ActiveRecord
          class Schema
            def self.[]: (untyped version) -> ActiveRecord::Migration::Current
          end
          class Migration
            class Current
              def define: (version: untyped) { () [self: instance] -> void } -> void
              def create_table: (untyped table_name, **untyped options) { (ActiveRecord::ConnectionAdapters::ColumnMethods t) -> void } -> void
            end
          end
          module ConnectionAdapters
            module ColumnMethods
              %a{siggen:
                class <%= create_table.table_name.classify %>
                  <% names.each do |name| %>
                    def <%= name %>: () -> String
                  <% end %>
                end
              }
              def text: (*Array[untyped] names, **untyped options) -> void
            end
            class TableDefinition
              include ColumnMethods
            end
          end
        end
      SIG
      expected = <<~SIGGEN
        class Article
          def body: () -> String
        end
      SIGGEN
      siggen = RBS::Siggen.new
      siggen.add_signature(sig_string)
      siggen.analyze_ruby(ruby_string)

      assert_equal expected, siggen.generate
    end
  end
end
