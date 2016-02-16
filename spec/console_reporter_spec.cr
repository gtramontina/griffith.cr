require "./spec_helper"

module Griffith
  describe ConsoleReporter do
    it "renders the task as reported" do
      reporter = ConsoleReporter.new(output = MemoryIO.new)
      reporter.report_on(task1 = Task.new("A test"))
      reporter.report_on(task2 = Task.new("Another test"))
      reporter.report_on(task3 = Task.new("Yet another test"))

      output.to_s.split('\n').should eq [
        "A test                                              ",
        "Another test                                        ",
        "Yet another test                                    ",
        "",
      ]
    end

    describe "when updating a task" do
      it "moves the cursor to and back from the corresponding task line" do
        reporter = ConsoleReporter.new(output = MemoryIO.new)
        reporter.report_on(task1 = Task.new("A test"))
        reporter.report_on(task2 = Task.new("Another test"))
        reporter.report_on(task3 = Task.new("Yet another test"))

        task1.running
        task2.done
        task3.fail

        # NOTE: \e[?25h is already included in the `split` below, so all
        #       ….ends_with? do not have this value in the end. Marked with a *.
        updates_by_line = output.to_s.split('\n').last.split("\e[?25h")

        task1_update = updates_by_line[0]
        task1_update.starts_with?("\e[?25l\e[3A\e[2K").should eq true
        task1_update.ends_with?("\e[3B\e[1G").should eq true # *

        task2_update = updates_by_line[1]
        task2_update.starts_with?("\e[?25l\e[2A\e[2K").should eq true
        task2_update.ends_with?("\e[2B\e[1G").should eq true # *

        task3_update = updates_by_line[2]
        task3_update.starts_with?("\e[?25l\e[1A\e[2K").should eq true
        task3_update.ends_with?("\e[1B\e[1G").should eq true # *
      end
    end
  end
end
