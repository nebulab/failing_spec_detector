# frozen_string_literal: true

module FailingSpecDetector
  # Combiner class to combine and group the failures by exception
  class Combiner
    def initialize(exceptions, failures)
      @exceptions = exceptions
      @failures = failures
    end

    def combine
      puts "Failing specs detector:\n\n\n"
      @exceptions.uniq.each do |exception|
        puts "#{exception}:\n\n"
        related_examples = @failures.select { |failure| failure.exception == exception }
        next if related_examples.empty?

        related_examples.each do |failure|
          puts "#{failure.backtrace}:\n"
        end
        puts "\n\n\n"
      end
    end
  end
end
