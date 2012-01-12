# -*- encoding: utf-8 -*-
require File.expand_path('../lib/baton/baton-ping/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Carlos Vilhena"]
  gem.email         = ["carlosvilhena@gmail.com"]
  gem.description   = "Baton Ping - ping servers"
  gem.summary       = "Baton Ping - ping servers"
  gem.homepage      = ""

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n").reject! { |fn| fn.include? ".tgz" }
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n").reject! { |fn| fn.include? ".tgz" }
  gem.name          = "baton_ping"
  gem.require_paths = ["lib"]
  gem.version       = Baton::Ping::VERSION

  gem.add_runtime_dependency "baton", "~> 0.3.0"
  gem.add_runtime_dependency "amqp", "~> 0.8.4"
  gem.add_runtime_dependency "eventmachine", "~> 1.0.0.beta.4"
  gem.add_runtime_dependency "em-http-request", "1.0.0"

  gem.add_development_dependency "rspec", "~> 2.7"
  gem.add_development_dependency "moqueue", "~> 0.1.4"
  gem.add_development_dependency "fakefs", "~> 0.4.0"
  gem.add_development_dependency "rake", "~> 0.9.2"
  gem.add_development_dependency "webmock", "~> 1.7.7"
end
