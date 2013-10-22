require "bundler/gem_tasks"
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec_unit) do |t, task_args|
  t.rspec_opts = "--tag ~acceptance"
end

task :default => :spec_unit
