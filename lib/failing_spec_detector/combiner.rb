# frozen_string_literal: true

module FailingSpecDetector
  # Combiner class to combine and group the failures by exception
  class Combiner
    def initialize(exceptions, failures)
      @exceptions = exceptions
      @failures = failures
      @filename = 'failing_specs_detector_log.txt'
    end

    def combine
      File.write(@filename, "Failing spec detector:\n\n\n")
      return if @exceptions.empty?

      @exceptions.uniq.each do |exception|
        File.write(@filename, "#{exception}:\n\n", mode: 'a')
        related_examples = @failures.select { |failure| failure.exception == exception }
        next if related_examples.empty?

        related_examples.each do |failure|
          File.write(@filename, "#{failure.backtrace}:\n", mode: 'a')
        end
        File.write(@filename, "\n\n\n", mode: 'a')
      end
      File.write(@filename, '----------------------------------------------------------------', mode: 'a')
    end
  end
end
