# frozen_string_literal: true

require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)

desc "validate rbs"
task :rbs_validate do
  command = %w(
    rbs
    --repo vendor/rbs/gem_rbs_collection/gems/
    -r date
    -r uri
    -r faraday:2.5
    -r hashie:5.0
    -I sig/
    validate
    --silent
  ).join(" ")

  sh command
end

task default: %i[spec rbs_validate]
