require "./spec_helper"

module Griffith
  class PhonySubscriber
    include Subscriber
    getter :event_name, :data

    def on_event(@event_name, @data)
    end
  end

  task = Task.new("A test")
  task.subscribe(phony_subscriber = PhonySubscriber.new)

  describe Task do
    context "attributes" do
      it "sets details" do
        task.details("some_file.cr").should eq task
        task.details.should eq "some_file.cr"
      end

      it "sets status message" do
        task.status_message("reading…").should eq task
        task.status_message.should eq "reading…"
      end

      it "sets running status message" do
        task.running("reading…").should eq task
        task.status_message.should eq "reading…"
      end

      it "sets done status message" do
        task.done("Done!").should eq task
        task.status_message.should eq "Done!"
      end

      it "sets fail status message" do
        task.fail("Boo… :-(").should eq task
        task.status_message.should eq "Boo… :-("
      end
    end

    context "events" do
      it "emits upon changing details" do
        task.details("some_file.cr")
        phony_subscriber.event_name.should eq :details_updated
        phony_subscriber.data.should eq task
      end

      it "emits upon changing status message" do
        task.status_message("reading…")
        phony_subscriber.event_name.should eq :status_message_updated
        phony_subscriber.data.should eq task
      end

      it "emits upon changing status to running" do
        task.running
        phony_subscriber.event_name.should eq :running
        phony_subscriber.data.should eq task
      end

      it "emits upon changing status to done" do
        task.done
        phony_subscriber.event_name.should eq :done
        phony_subscriber.data.should eq task
      end

      it "emits upon changing status to fail" do
        task.fail
        phony_subscriber.event_name.should eq :fail
        phony_subscriber.data.should eq task
      end
    end
  end
end
