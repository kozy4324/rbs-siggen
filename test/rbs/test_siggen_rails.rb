# frozen_string_literal: true

require "test_helper"

module RBS
  class TestSiggen < Minitest::Test
    def test_activerecord_schema
      ruby_string = <<~RUBY
        ActiveRecord::Schema[8.1].define(version: 2026_01_31_051626) do
          create_table "articles", force: :cascade do |t|
            t.text "body"
            t.text "tag", null: false
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
              %a{siggen:
                # <%= ___source %>
                class <%= table_name.classify %>
                end
              }
              def create_table: (untyped table_name, **untyped options) { (ActiveRecord::ConnectionAdapters::ColumnMethods t) -> void } -> void
            end
          end
          module AttributeMethods
            # ___comment_of method can pick comment for class/module
            module Read
              # The comment for this line is inserted
              # by the ___comment_of method.
              def read_attribute: () -> void
            end
          end
          module ConnectionAdapters
            module ColumnMethods
              %a{siggen:
                class <%= create_table.table_name.classify %>
                  module GeneratedAttributeMethods
                    <% names.each do |name| %>
                      # In schema.rb, this column is declared as:
                      # ```ruby
                      # <%= ___source %>
                      # ```
                      # <%= ___comment_of["ActiveRecord::AttributeMethods::Read"] %>
                      # <%= ___comment_of["ActiveRecord::AttributeMethods::Read#read_attribute"] %>
                      def <%= name %>: () -> String<%= "?" unless options[:null] == false %>
                    <% end %>
                  end
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
        # create_table "articles", force: :cascade do |t|
        #   t.text "body"
        #   t.text "tag", null: false
        # end
        class Article
          module GeneratedAttributeMethods
            # In schema.rb, this column is declared as:
            # ```ruby
            # t.text "body"
            # ```
            # ___comment_of method can pick comment for class/module
            # The comment for this line is inserted
            # by the ___comment_of method.
            def body: () -> String?

            # In schema.rb, this column is declared as:
            # ```ruby
            # t.text "tag", null: false
            # ```
            # ___comment_of method can pick comment for class/module
            # The comment for this line is inserted
            # by the ___comment_of method.
            def tag: () -> String
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
