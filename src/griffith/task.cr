module Griffith
  # :nodoc:
  module Subscriber
  end

  # :nodoc:
  module Publisher
    def subscribe(listener)
      listeners << listener
    end

    private def broadcast(event_name, *args)
      listeners.each do |listener|
        listener.on_event(event_name, *args)
      end
    end

    private def listeners
      @listeners ||= [] of Subscriber
    end
  end

  class Task
    include Publisher

    getter :description, :status_message, :details

    # Creates a new task with the given description.
    def initialize(@description)
    end

    # Sets the details text.
    def details(@details)
      broadcast(:details_updated, self)
      self
    end

    # Sets the status message.
    def status_message(@status_message)
      broadcast(:status_message_updated, self)
      self
    end

    # Sets the status message. Defaults to: `Griffith::Config::DEFAULT_RUNNING_MESSAGE`.
    def running(@status_message = Config.running_message)
      broadcast(:running, self)
      self
    end

    # Sets the status message. Defaults to: `Griffith::Config::DEFAULT_DONE_MESSAGE`.
    def done(@status_message = Config.done_message)
      broadcast(:done, self)
      self
    end

    # Sets the status message. Defaults to: `Griffith::Config::DEFAULT_FAIL_MESSAGE`.
    def fail(@status_message = Config.fail_message)
      broadcast(:fail, self)
      self
    end
  end
end
