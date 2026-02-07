# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path("../lib", __dir__)
v = $VERBOSE
$VERBOSE = false
require "rbs/siggen"
$VERBOSE = v

require "minitest/autorun"
