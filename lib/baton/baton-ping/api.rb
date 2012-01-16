require "baton"
require "baton/api"
require "json"

module Baton
  class PingAPI < Baton::API

    def self.ping(env)
      message = {type: "ping"}
      publish(message.to_json, "#{env}")
    end

  end
end
