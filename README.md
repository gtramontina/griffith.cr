<img src="https://upload.wikimedia.org/wikipedia/commons/7/7c/Los_Angeles_Pollution.jpg">

# griffith.cr

Beautiful UI for showing tasks running on the command line.

## Purpose

Instead of just logging long running tasks to the console, give your users a simple status dashboard.

![griffith](https://cloud.githubusercontent.com/assets/374635/13062397/96859126-d425-11e5-833a-6487e03a24b8.gif)

## Installation

Add this to your application's `shard.yml`:

```yaml
dependencies:
  griffith:
    github: gtramontina/griffith.cr
```

## Usage

```crystal
require "griffith"
```

### Config

```crystal
Griffith.config do |c|
  c.prefix = "[my-app] "                 # Default: ""
  c.done_message = "OK".colorize(:green) # Default: "✓ Done".colorize(:green)
  c.fail_message = "NOK".colorize(:red)  # Default: "✗ Failed".colorize(:red)
  c.running_message = "downloading…"     # Default: "…".colorize(:yellow)
  c.reporter = MyCustomReporter.new      # Default: ConsoleReporter.new
end
```

### Tasking out

```crystal
# Add a task to display
task = Griffith.create_task("Task description")

# While working on the task, update the status
task.running("some comment")

# Optionally give details
task.details("#{percent}%")

# Chain commands
task.status_message("Downloading…")
    .details("#{percent}%")

# When complete
task.done("Finished!")

# Or if it failed
task.fail("Oops")
```

### Terminology

```
[Test Runner] Running tests on Safari                            Running Now  50%  CSS3 Tests
↑ prefix      ↑ description (column width of 50 chars)           ↑ status     ↑ details
```

## Contributing

1. Fork it ( https://github.com/gtramontina/griffith.cr/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Acknowledgements

This shard was totally inspired by [@dylang's](https://github.com/dylang) [observatory](https://github.com/dylang/observatory), hence the [name](https://en.wikipedia.org/wiki/Griffith_Observatory) and README similarity! Thank you, [@dylang](https://github.com/dylang)! :beers::smile:


## TODO

- [ ] Make the reporter format more flexible. Meanwhile you have to extend `ConsoleReporter` and override `#render(task)` in order to change the format.
