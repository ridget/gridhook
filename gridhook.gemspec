$:.push File.expand_path("../lib", __FILE__)
require 'gridhook/version'

Gem::Specification.new do |s|
  s.name          = 'gridhook'
  s.version       = Gridhook::VERSION
  s.authors       = ['Lee Jarvis', 'Tom Ridge']
  s.email         = ['ljjarvis@gmail.com']
  s.description   = 'A Rails engine to provide an endpoint for SendGrid webhooks'
  s.summary       = 'A SendGrid webhook endpoint'
  s.homepage      = 'https://github.com/ridget/gridhook'
  s.license       = 'MIT'

  s.required_ruby_version = Gem::Requirement.new('>= 1.9.1')

  s.files         = `git ls-files`.split($/)

  s.add_dependency 'rails', '>= 4.2.0'
  s.add_dependency "multi_json", '>= 1.12'

  s.add_development_dependency "pg"
end
