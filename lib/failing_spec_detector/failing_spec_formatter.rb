# frozen_string_literal: true

require 'rspec/core/formatters/base_text_formatter'
require_relative 'failure'
require 'yaml'

module FailingSpecDetector
  class FailingSpecFormatter < RSpec::Core::Formatters::BaseTextFormatter
    RSpec::Core::Formatters.register self, :example_failed, :stop

    def initialize(output)
      super(output)
      @failures = []
      @exceptions = []
      @failures_filename = "failures_log_#{ENV.fetch('TEST_ENV_NUMBER', nil)}.yml"
      @exceptions_filename = "exceptions_log_#{ENV.fetch('TEST_ENV_NUMBER', nil)}.yml"
    end

    def example_failed(failure)
      exception = failure.exception.to_s.gsub(/\e\[(\d+)m/, '')

      @exceptions << exception unless @exceptions.include?(exception)

      failure = Failure.new(exception, failure.formatted_backtrace.join("\n"))

      @failures << failure
    end

    def stop(_notification)
      File.write(@exceptions_filename, YAML.dump(@exceptions), mode: 'w')
      File.write(@failures_filename, YAML.dump(@failures), mode: 'w')
    end
  end
end
