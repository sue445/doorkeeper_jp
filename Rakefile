# frozen_string_literal: true

require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)

desc "validate rbs"
task :rbs_validate do
  sh "rbs validate --silent"
end

task default: %i[spec rbs_validate]
