require "baton"
require "amqp"
require "pusher"
require "json"
require "eventmachine"

module Baton
  class PingMonitor
    include Baton::Logging

    def self.run
      monitor = PingMonitor.new
      monitor.run
    end

    def run
      logger.info "Starting baton-ping monitor v#{Baton::VERSION}"

      EM.run do
        connection = AMQP.connect(Baton.configuration.connection_opts)

        channel  = AMQP::Channel.new(connection)
        queue    = channel.queue("baton-ping-monitor")
        exchange_out = channel.direct(Baton.configuration.exchange_out)

        queue.bind(exchange_out).subscribe do |payload|
          logger.info "Message read: #{payload}"
        end
      end

    end
  end
end
