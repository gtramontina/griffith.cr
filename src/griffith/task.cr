require "./publisher"

module Griffith
  class Task
    include Publisher(Task)

    getter :description, :status_message, :details

    # Creates a new task with the given description.
    def initialize(@description : String)
    end

    # Sets the details text.
    def details(@details : String)
      broadcast(:details_updated, self)
      self
    end

    # Sets the status message.
    def status_message(@status_message : String)
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
