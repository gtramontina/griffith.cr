require "./task"
require "./reporter"
require "./subscriber"
require "ansi-escapes"

module Griffith
  class ConsoleReporter
    include Reporter
    include Subscriber(Task)
    include AnsiEscapes

    def initialize(@io : IO = STDOUT)
      @tasks_lines = {} of Task => Int32
      @current_line = 1
      @mutex = Mutex.new
    end

    def report_on(task : Task)
      @mutex.synchronize do
        task.subscribe(self)
        @tasks_lines[task] = @current_line
        @current_line += 1
        @io.puts(render(task))
      end
    end

    def on_event(_event_name, task)
      write(render(task), @tasks_lines[task])
    end

    private def render(task)
      "%s%-50s %s %s" % [Config.prefix, task.description, task.status_message, task.details]
    end

    private def write(text, line_number)
      @mutex.synchronize do
        position = @current_line - line_number
        @io.print(String.build do |line|
          line << Cursor::HIDE << Cursor.up(position) << Erase::LINE
          line << text
          line << Cursor.down(position) << Cursor.to(0) << Cursor::SHOW
        end)
        @io.flush
      end
    end
  end
end
