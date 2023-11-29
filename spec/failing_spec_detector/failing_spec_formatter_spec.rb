# frozen_string_literal: true

require 'spec_helper'

RSpec.describe FailingSpecDetector::FailingSpecFormatter do
  let(:formatter) { described_class.new(output) }
  let(:output) { Tempfile.new('./output_to_close') }
  let(:expected_file_path) { './spec/support/expected_file.txt' }
  let(:actual_file_path) { './log.txt' }
  let(:expected_file) { File.new(expected_file_path, 'r') }
  let(:actual_file) { File.new(actual_file_path, 'r') }

  let(:examples) { [failed_notification1, failed_notification2, failed_notification3] }
  let(:expected_exceptions) { [failed_notification1.exception.to_s, failed_notification3.exception.to_s] }
  let(:failed_notification1)  { ::RSpec::Core::Notifications::ExampleNotification.for(failed_example1) }
  let(:failed_notification2)  { ::RSpec::Core::Notifications::ExampleNotification.for(failed_example2) }
  let(:failed_notification3)  { ::RSpec::Core::Notifications::ExampleNotification.for(failed_example3) }
  let(:failed_example1) do
    exception = ::RuntimeError.new('Test Error 1')
    exception.set_backtrace ["/spec/one_spec.rb:11:in `some_method'"]

    example = self.class.example

    example.metadata[:file_path] = '/spec/one_spec.rb'
    example.metadata[:execution_result].status = :failed
    example.metadata[:execution_result].exception = exception

    example
  end

  let(:failed_example2) do
    exception = ::RuntimeError.new('Test Error 1')
    exception.set_backtrace ["/spec/two_spec.rb:20:in `some_method'"]

    example = self.class.example

    example.metadata[:file_path] = '/spec/two_spec.rb'
    example.metadata[:execution_result].status = :failed
    example.metadata[:execution_result].exception = exception

    example
  end

  let(:failed_example3) do
    exception = ::RuntimeError.new('Test Error 2')
    exception.set_backtrace ["/spec/three_spec.rb:4:in `some_method'"]

    example = self.class.example

    example.metadata[:file_path] = '/spec/three_spec.rb'
    example.metadata[:execution_result].status = :failed
    example.metadata[:execution_result].exception = exception

    example
  end

  it 'prints the failing specs backtraces grouped by exception' do
    mock_run_specs
    expect(FileUtils.compare_file(actual_file, expected_file)).to be_truthy
  end

  def mock_run_specs
    examples.each do |example|
      formatter.example_failed(example)
    end

    formatter.stop(:stop)
  end
end
