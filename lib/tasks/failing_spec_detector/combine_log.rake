# frozen_string_literal: true

require 'yaml'
require_relative '../../failing_spec_detector/failure'
require_relative '../../failing_spec_detector/combiner'

namespace :failing_specs_detector do
  desc 'Combine logs and generate log files'
  task :combine_log do
    failures = []
    exceptions = []
    failures_file_paths = Dir['failures_log_*.yml']
    exceptions_file_paths = Dir['exceptions_log_*.yml']
    failures_file_paths.each do |file_path|
      failures.concat(YAML.load_file(file_path, permitted_classes: [FailingSpecDetector::Failure]))
      File.delete(file_path)
    end
    exceptions_file_paths.each do |file_path|
      exceptions.concat(YAML.load_file(file_path))
      File.delete(file_path)
    end

    combiner = FailingSpecDetector::Combiner.new(exceptions, failures)

    combiner.combine_html
    combiner.combine
  end
end
