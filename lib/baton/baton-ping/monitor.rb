require "baton"
require "amqp"
require "json"
require "eventmachine"
require "baton/channel"

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

        baton_channel	= Baton::Channel.new
        queue         = baton_channel.channel.queue("baton-ping-monitor")
        exchange_out  = baton_channel.channel.direct(Baton.configuration.exchange_out)

        queue.bind(exchange_out).subscribe do |payload|
          logger.info "Message read: #{payload}"
          # Do something with the payload here
        end
      end

    end
  end
end
