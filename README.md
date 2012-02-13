# baton-ping

[![Build Status](https://secure.travis-ci.org/digital-science/baton-ping.png)](http://travis-ci.org/digital-science/baton-ping)

baton-ping is a [baton's](https://github.com/digital-science/baton) extension that allows one to send ping messages to servers on a specific environment. The three major components are:

- [API](https://github.com/digital-science/baton-ping/blob/master/lib/baton/baton-ping/api.rb)
- [Service](https://github.com/digital-science/baton-ping/blob/master/lib/baton/baton-ping.rb)
- [Monitor](https://github.com/digital-science/baton-ping/blob/master/lib/baton/baton-ping/monitor.rb)

Each part is explained in detail below.

## baton-ping API

baton-ping uses pubsub design to send messages to groups of services. The baton-ping API is a useful client library that allows messages to be sent synchronously to the correct exchange so that it can be easily integrated with existing web applications (such as hubot or web interfaces for one-click deployment). Each operation sends a message to a RabbitMQ exchange, which will route the message to the correct instance(s). It provides two calls.

### Baton::PingAPI.ping

    Baton::PingAPI.ping(<environment>)

This query sends sends the message

    {:type => "ping"}

With the routing key `<environment>`. Thus, every baton-ping service that registered a queue with the given routing key will receive the message.

## baton-ping service

baton-ping service is a EventMachine based app that runs on instances you wish to ping. The service reads from an [ohai](http://wiki.opscode.com/display/chef/Ohai) configuration file the following information:

- The environment of the instance (production, development, etc);
- The list of applications that are running on the instance.

With that information, baton-ping's service starts up one input queue for
each application with a unique queue name and with a routing key like
this:

    <environment>

These queues are registered on baton-ping's main exchange and therefore will
receive messages sent via baton-ping's API.

After receiving one request (e.g. ping), the service will process it and send status messages (info or error messages) to a common output exchange, which will be processed by baton-ping monitor.


## baton-ping monitor

This service simply listens to baton-ping service's output exchange and logs all messages. This allows, for example, hubot to print pong responses to campfire.

## Getting Started

    git clone git@github.com:digital-science/baton-ping.git
    cd baton-ping
    bundle install

### Running

#### API

In a Rails project, add an initializer to config/initializers/baton.rb
with the necessary configuration:

    Baton.configure do |c|
      c.host = "host"
      c.vhost = "vhost"
      c.user = "user"
      c.password = "password"
      c.exchange = "input_exchange"
      c.exchange_out = "output_exchange"
    end

Then, query the API as stated 

#### Service

Run the following command:

    bundle exec bin/baton-ping

#### Monitor

Run the following command:

    bundle exec bin/baton-ping-monitor

### Testing

    bundle exec rspec
