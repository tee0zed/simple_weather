# frozen_string_literal: true

require './lib/simple_weather/version'

Gem::Specification.new do |s|
  s.required_ruby_version = '~> 3.1'

  s.name          = 'simple_weather'
  s.version       = SimpleWeather::VERSION
  s.summary       = 'Simple Weather Gem'
  s.description   = 'A simple temperature fetcher gem'
  s.require_paths = %w[lib]
  s.platform      = Gem::Platform::RUBY
  s.files         = Dir['lib/**/*.rb']
  s.test_files    = Dir['spec/**/*.rb']
  s.homepage      = 'https://rubygems.org/gems/simple_weather_gem'
  s.license       = 'MIT'
  s.authors       = ['Tee Zed']
  s.email         = 'tee0zed@gmail.com'

  s.add_runtime_dependency 'dotenv', '~> 2.7'
  s.add_runtime_dependency 'httparty', '~> 0.20.0'

  s.add_development_dependency 'bundler', '~> 2.3'
  s.add_development_dependency 'rake', '~> 13.0'
  s.add_development_dependency 'rspec', '~> 3.11'
  s.add_development_dependency 'vcr'
  s.add_development_dependency 'webmock'
end
