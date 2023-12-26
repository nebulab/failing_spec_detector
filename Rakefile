require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)

import './lib/tasks/failing_spec_detector/print_log.rake'

task :default => :spec
