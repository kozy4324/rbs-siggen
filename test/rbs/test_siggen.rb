# frozen_string_literal: true

require "test_helper"

module RBS
  class TestSiggen < Minitest::Test
    def test_hello
      assert_equal :hello, RBS::Siggen.hello
    end
  end
end
