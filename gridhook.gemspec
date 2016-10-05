$:.push File.expand_path("../lib", __FILE__)
require 'gridhook/version'

Gem::Specification.new do |spec|
  spec.name          = 'gridhook'
  spec.version       = Gridhook::VERSION
  spec.authors       = ['Lee Jarvis', 'Tom Ridge']
  spec.email         = ['ljjarvis@gmail.com']
  spec.description   = 'A Rails engine to provide an endpoint for SendGrid webhooks'
  spec.summary       = 'A SendGrid webhook endpoint'
  spec.homepage      = 'https://github.com/ridget/gridhook'
  spec.license       = 'MIT'

  spec.required_ruby_version = Gem::Requirement.new('>= 1.9.1')

  spec.files         = `git ls-files`.split($/)

  spec.add_dependency 'rails', '>= 4.2.0'
  spec.add_dependency "multi_json", '>= 1.12'

  spec.add_development_dependency "pg"
end
