# frozen_string_literal: true

require "bundler/gem_tasks"
require "minitest/test_task"

Minitest::TestTask.create

require "rubocop/rake_task"

RuboCop::RakeTask.new

require "steep/rake_task"
Steep::RakeTask.new do |t|
  t.check.severity_level = :error
  t.watch.verbose
end

task default: %i[test rubocop steep]

desc "E2E test for siggen"
task :e2e_siggen do
  ENV["SIGGEN_DEBUG"] = "1"
  Dir.chdir("siggen-test/activerecord_model_sqlite3") do
    sh %(rake run_siggen)
  end
  Rake::Task[:steep].invoke
end
