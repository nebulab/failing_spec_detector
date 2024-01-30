# frozen_string_literal: true

require 'erb'

module FailingSpecDetector
  # Combiner class to combine and group the failures by exception
  class Combiner
    def initialize(exceptions, failures)
      @exceptions = exceptions
      @failures = failures
      @filename = 'failing_specs_detector_log.txt'
      @html_filename = 'failing_specs_detector_log.html'
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

    def combine_html
      return if @exceptions.empty?

      template = ERB.new(File.read(File.join(File.dirname(__FILE__), 'views', 'template.erb')))
      File.write(@html_filename, template.result(binding))
    end
  end
end
