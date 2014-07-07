# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rack/haproxy_status/version'

Gem::Specification.new do |spec|
  spec.name          = "rack-haproxy_status"
  spec.version       = Rack::HaproxyStatus::VERSION
  spec.authors       = ["Marten Veldthuis"]
  spec.email         = ["marten@veldthuis.com"]
  spec.summary       = %q{Tiny mountable app that returns an HTTP state based on contents of a file.}
  spec.description   = %q{This app will return 503 if a config file contains "off", which will tell HAproxy to drop this node from the balancer backend.}
  spec.homepage      = "https://github.com/roqua/rack-haproxy_status"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency 'rspec'
end
