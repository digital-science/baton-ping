module Baton
  class PingConsumer < Baton::Consumer

    def process_message(message, consumer_manager)
      case message["type"]
      when "ping"
        logger.info "received current ping for #{consumer_name}: #{message}"
        notify(attributes)
      else
        raise Exception, "Unknown message type for #{consumer_name}: #{message}"
      end
    end

    def routing_key
      "#{server.environment}"
    end

    def attributes
      {type: "pong"}.merge(server.attributes)
    end

  end
end
