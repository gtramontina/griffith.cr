require "./spec_helper"

module Griffith
  class DummyReporter; end

  Spec.after_each { Config.reset }

  describe Config do
    it "defaults reporter" do
      Config.reporter.class.should eq ConsoleReporter
    end

    it "defaults prefix" do
      Config.prefix.should eq ""
    end

    it "defaults done message" do
      Config.done_message.should eq "✓ Done".colorize(:green)
    end

    it "defaults fail message" do
      Config.fail_message.should eq "✗ Failed".colorize(:red)
    end

    it "defaults running message" do
      Config.running_message.should eq "…".colorize(:yellow)
    end

    it "allows changing values" do
      Griffith.config do |c|
        c.reporter = DummyReporter.new
        c.prefix = "[my project]"
        c.done_message = ":-)"
        c.fail_message = ":-("
        c.running_message = "in progress"
      end

      Config.reporter.class.should eq DummyReporter
      Config.prefix.should eq "[my project]"
      Config.done_message.should eq ":-)"
      Config.fail_message.should eq ":-("
      Config.running_message.should eq "in progress"
    end
  end
end
