require "../src/griffith"
require "colorize"
require "spinner-frames"
require "faker"
require "random"

NUMBER_OF_TASKS = 10
CHANNEL         = Channel(Nil).new

Griffith.config do |c|
  c.prefix = "[random] ".colorize(:light_green).to_s
end

def run(task)
  spawn do
    done = false
    step = 0
    pace = 0.1
    timeout = Random.rand(1..10)
    spinner = SpinnerFrames.new(SpinnerFrames::Charset[:snake])
    spawn do
      until done
        task.running(spinner.next.colorize(:blue).to_s)
        task.details(("%02.1f%%" % (step/timeout*100)).colorize(:dark_gray).to_s)
        step += pace
        sleep pace
      end
    end
    sleep timeout
    done = true
    [true, false].sample ? task.fail : task.done
    task.details("")
    CHANNEL.send(nil)
  end
end

NUMBER_OF_TASKS.times do
  run(Griffith.create_task(Faker::Name.name.colorize(:light_gray).to_s))
  sleep [0.01, 0, 0.5, 0.05].sample
end
NUMBER_OF_TASKS.times { CHANNEL.receive }
