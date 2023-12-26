# frozen_string_literal: true

module FailingSpecDetector
  # a simplified Failure class allow us to store only the needed information
  class Failure
    attr_accessor :exception, :backtrace

    def initialize(exception, backtrace)
      @exception = exception
      @backtrace = backtrace
    end
  end
end
