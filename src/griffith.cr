require "./griffith/*"

module Griffith
  # Registers a new task with the reporter.
  def self.create_task(description)
    Config.reporter.report_on(task = Task.new(description))
    task
  end
end
