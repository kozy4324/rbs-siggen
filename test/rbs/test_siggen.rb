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
  end
end
