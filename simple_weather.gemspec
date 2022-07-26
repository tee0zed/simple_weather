# frozen_string_literal: true

Gem::Specification.new do |s|
  s.required_ruby_version = '~> 3.1'

  s.name          = 'simple_weather'
  s.version       = SimpleWeather::VERSION
  s.summary       = 'Simple Weather Gem'
  s.description   = 'A simple weather fetcher gem'
  s.authors       = ['Taras Zhuk']
  s.email         = 'tee0zed@gmail.com'
  s.require_paths = %w[lib]
  s.platform      = Gem::Platform::RUBY
  s.files         = Dir['lib/**/*', File::FNM_DOTMATCH]
  s.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  s.homepage      = 'https://rubygems.org/gems/simple_weather_gem'
  s.license       = 'MIT'

  s.add_runtime_dependency 'dotenv', '~> 2.7'
  s.add_runtime_dependency 'httparty', '~> 0.20.0'

  s.add_development_dependency 'bundler', '~> 2.3'
  s.add_development_dependency 'bundler', '~> 2.3'
  s.add_development_dependency 'rake', '~> 13.0'
  s.add_development_dependency 'rspec', '~> 3.11'
  s.add_development_dependency 'vcr'
  s.add_development_dependency 'webmock'
end
