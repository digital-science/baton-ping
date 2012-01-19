require "spec_helper"
require "baton"
require "baton/consumer"
require "baton/server"
require "baton/baton-ping/ping_consumer"

describe Baton::PingConsumer do

  before :each do
    Baton::Server.any_instance.stub(:facts).and_return({
      "fqdn" => "server.dsci.it",
      "chef_environment" => "production"
    })
  end

  subject {
    Baton::PingConsumer.new("ping", Baton::Server.new)
  }

  describe "#process_message" do
    context "given a ping pessage" do
      it "should response with a pong message" do
        subject.should_receive(:notify).with(subject.attributes)
        subject.process_message({"type" => "ping"})
      end
    end

    context "given an invalid message" do
      it "should raise an exception" do
        expect{subject.process_message({"type" => "invalid"})}.to raise_error
      end
    end
  end

  describe "#routing_key" do
    context "given an instance of PingConsumer" do
      it "should return the environment of the server as routing key" do
        subject.routing_key.should eq("production")
      end
    end
  end

  describe "#attributes" do
    context "given an instance of PingConsumer" do
      it "should return a set of attributes for the pong message" do
        subject.attributes.should eq({:type=>"pong", :environment=>"production", :fqdn=>"server.dsci.it", :app_names=>[]})
      end
    end
  end

end
