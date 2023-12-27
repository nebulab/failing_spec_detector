# frozen_string_literal: true

require 'spec_helper'

RSpec.describe FailingSpecDetector::FailingSpecFormatter do
  let(:formatter) { described_class.new(output) }
  let(:output) { Tempfile.new('./output_to_close') }
  let(:expected_failures_file_path) { './spec/support/expected_failures_log_.yml' }
  let(:expected_exceptions_file_path) { './spec/support/expected_exceptions_log_.yml' }
  let(:actual_failures_file_path) { './failures_log_.yml' }
  let(:actual_exceptions_file_path) { './exceptions_log_.yml' }
  let(:expected_failures_file) { File.new(expected_failures_file_path, 'r') }
  let(:expected_exceptions_file) { File.new(expected_exceptions_file_path, 'r') }
  let(:actual_failures_file) { File.new(actual_failures_file_path, 'r') }
  let(:actual_exceptions_file) { File.new(actual_exceptions_file_path, 'r') }

  let(:examples) { [failed_notification1, failed_notification2, failed_notification3] }
  let(:expected_exceptions) { [failed_notification1.exception.to_s, failed_notification3.exception.to_s] }
  let(:failed_notification1)  { RSpec::Core::Notifications::ExampleNotification.for(failed_example1) }
  let(:failed_notification2)  { RSpec::Core::Notifications::ExampleNotification.for(failed_example2) }
  let(:failed_notification3)  { RSpec::Core::Notifications::ExampleNotification.for(failed_example3) }
  let(:failed_example1) do
    exception = RuntimeError.new('Test Error 1')
    exception.set_backtrace ["/spec/one_spec.rb:11:in `some_method'"]

    example = self.class.example

    example.metadata[:file_path] = '/spec/one_spec.rb'
    example.metadata[:execution_result].status = :failed
    example.metadata[:execution_result].exception = exception

    example
  end

  let(:failed_example2) do
    exception = RuntimeError.new('Test Error 1')
    exception.set_backtrace ["/spec/two_spec.rb:20:in `some_method'"]

    example = self.class.example

    example.metadata[:file_path] = '/spec/two_spec.rb'
    example.metadata[:execution_result].status = :failed
    example.metadata[:execution_result].exception = exception

    example
  end

  let(:failed_example3) do
    exception = RuntimeError.new('Test Error 2')
    exception.set_backtrace ["/spec/three_spec.rb:4:in `some_method'"]

    example = self.class.example

    example.metadata[:file_path] = '/spec/three_spec.rb'
    example.metadata[:execution_result].status = :failed
    example.metadata[:execution_result].exception = exception

    example
  end

  it 'stores the failing specs failures and exceptions in yml files' do
    mock_run_specs
    expect(FileUtils.compare_file(actual_failures_file, expected_failures_file)).to be_truthy
    expect(FileUtils.compare_file(actual_exceptions_file, expected_exceptions_file)).to be_truthy
  end

  def mock_run_specs
    examples.each do |example|
      formatter.example_failed(example)
    end

    formatter.stop(:stop)
  end
end
