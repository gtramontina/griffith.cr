module Griffith
  module Publisher(T)
    def subscribe(listener : Subscriber(T))
      listeners << listener
    end

    private def broadcast(event_name, entity)
      listeners.each do |listener|
        listener.on_event(event_name, entity)
      end
    end

    private def listeners
      @listeners ||= [] of Subscriber(T)
    end
  end
end
