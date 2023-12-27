require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
require 'rubocop/rake_task'

RSpec::Core::RakeTask.new(:spec)

import './lib/tasks/failing_spec_detector/combine_log.rake'

task default: %i[
  spec
  rubocop
]

RuboCop::RakeTask.new
