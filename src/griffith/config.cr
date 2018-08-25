require "colorize"

module Griffith
  private class Config
    @reporter : Reporter
    @done_message : String
    @fail_message : String
    @running_message : String

    INSTANCE = new
    property :reporter, :prefix, :done_message, :fail_message, :running_message

    private def initialize
      @reporter = ConsoleReporter.new
      @prefix = ""
      @done_message = "✓ Done".colorize(:green).to_s
      @fail_message = "✗ Failed".colorize(:red).to_s
      @running_message = "…".colorize(:yellow).to_s
    end

    def reset
      initialize
    end

    def self.reporter
      INSTANCE.reporter
    end

    def self.prefix
      INSTANCE.prefix
    end

    def self.done_message
      INSTANCE.done_message
    end

    def self.fail_message
      INSTANCE.fail_message
    end

    def self.running_message
      INSTANCE.running_message
    end

    def self.reset
      INSTANCE.reset
    end
  end

  def self.config(&block)
    yield Config::INSTANCE
  end
end
