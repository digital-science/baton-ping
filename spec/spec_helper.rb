require 'rubygems'
require 'bundler'
Bundler.setup
require 'fakefs/spec_helpers'
require "moqueue"
require 'webmock/rspec'
require "baton/logging"

WebMock.disable_net_connect!

Baton::Logging.logger = "log/test.log"
