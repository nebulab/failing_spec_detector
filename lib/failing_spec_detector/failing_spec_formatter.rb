# frozen_string_literal: true

require 'rspec/core/formatters/base_text_formatter'

module FailingSpecDetector
  class FailingSpecFormatter < RSpec::Core::Formatters::BaseTextFormatter
    RSpec::Core::Formatters.register self, :example_failed, :stop

    def initialize(output)
      super(output)
      @failures = []
      @exceptions = []
      @filename = "failing_specs_detector_log_#{ENV.fetch('TEST_ENV_NUMBER', nil)}.txt"
    end

    def example_failed(failure)
      exception = failure.exception.to_s.gsub(/\e\[(\d+)m/, '')

      @exceptions << exception unless @exceptions.include?(exception)

      @failures << failure
    end

    def stop(_notification)
      File.write(@filename, "Failing spec detector log_#{ENV.fetch('TEST_ENV_NUMBER', nil)}:\n")
      return if @exceptions.empty?

      @exceptions.each do |exception|
        File.write(@filename, "#{exception}:\n\n", mode: 'a')
        related_examples = @failures.select { |failure| failure.exception.to_s.gsub(/\e\[(\d+)m/, '') == exception }
        next if related_examples.empty?

        related_examples.each do |failure|
          File.write(@filename, "#{failure.formatted_backtrace.join("\n")}:\n", mode: 'a')
        end
        File.write(@filename, "^^^^^^^^\n\n\n", mode: 'a')
      end
      File.write(@filename, '----------------------------------------------------------------', mode: 'a')
    end
  end
end
