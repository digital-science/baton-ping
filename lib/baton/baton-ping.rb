require "baton"
require "baton/service"
require "baton/baton-ping/ping_consumer"
require "baton/baton-ping/version"

module Baton
  class PingService < Baton::Service

    def setup_consumers
      srv = Baton::PingConsumer.new(server.fqdn, server)
      add_consumer(srv)
    end

  end
end
