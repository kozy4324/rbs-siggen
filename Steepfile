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
