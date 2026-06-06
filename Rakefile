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

desc "Generate siggen/*.rbs"
task :run_erb do
  infile = "siggen/activerecord_model.rbs.erb"
  outfile = "siggen/activerecord_model.rbs"
  sh %|ruby -rerb -e 'ERB.new(File.read("#{infile}"), trim_mode: ?-).run' > #{outfile}|
end

desc "E2E test for siggen"
task e2e_siggen: [:run_erb] do
  Dir.chdir("siggen-test/activerecord_model_sqlite3") do
    sh %(rake run_siggen)
  end
end

task install: :run_erb
