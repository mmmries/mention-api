# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mention/api/version'

Gem::Specification.new do |spec|
  spec.name          = "mention-api"
  spec.version       = Mention::Api::VERSION
  spec.authors       = ["Michael Ries"]
  spec.email         = ["michael@riesd.com"]
  spec.description   = "A wrapper for the mention.net API"
  spec.summary       = spec.description
  spec.homepage      = "https://github.com/hqmq/mention-api"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake", "~> 10.1"
  spec.add_development_dependency "rspec", "~> 2.14"
  spec.add_development_dependency "webmock", "~> 1.14"
  spec.add_runtime_dependency "rest-client", "~> 1.6.7"
  spec.add_runtime_dependency "virtus", "~> 1.0"
end
