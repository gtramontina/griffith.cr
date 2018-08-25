module Griffith
  module Subscriber(T)
    abstract def on_event(event_name : Symbol, entity : T)
  end
end
