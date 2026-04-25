# frozen_string_literal: true

D = Steep::Diagnostic

target :lib do
  signature "sig"
  ignore_signature "sig/test"
  check "lib"
end

target :test do
  unreferenced!
  signature "sig/test"
  check "test"
  ignore "test/lib"
  configure_code_diagnostics(D::Ruby.lenient)
end

target :siggen_test_activerecord_model_sqlite3 do
  unreferenced!
  signature "siggen/test/activerecord_model_sqlite3/sig"
  check "siggen/test/activerecord_model_sqlite3/test"
  configure_code_diagnostics(D::Ruby.lenient)
end
