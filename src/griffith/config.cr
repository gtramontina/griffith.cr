require "colorize"

module Griffith
  class Config
    DEFAULT_PREFIX          = ""
    DEFAULT_DONE_MESSAGE    = "✓ Done".colorize(:green)
    DEFAULT_FAIL_MESSAGE    = "✗ Failed".colorize(:red)
    DEFAULT_RUNNING_MESSAGE = "…".colorize(:yellow)

    Instance = new
    setter :reporter, :prefix, :done_message, :fail_message, :running_message
    private def initialize; end

    def reporter
      @reporter ||= ConsoleReporter.new
    end

    def prefix
      @prefix ||= DEFAULT_PREFIX
    end

    def done_message
      @done_message ||= DEFAULT_DONE_MESSAGE
    end

    def fail_message
      @fail_message ||= DEFAULT_FAIL_MESSAGE
    end

    def running_message
      @running_message ||= DEFAULT_RUNNING_MESSAGE
    end

    def reset
      @reporter = nil
      @prefix = nil
      @done_message = nil
      @fail_message = nil
      @running_message = nil
    end

    def self.reporter
      Instance.reporter
    end

    def self.prefix
      Instance.prefix
    end

    def self.done_message
      Instance.done_message
    end

    def self.fail_message
      Instance.fail_message
    end

    def self.running_message
      Instance.running_message
    end

    def self.reset
      Instance.reset
    end
  end

  def self.config(&block)
    yield Config::Instance
  end
end
