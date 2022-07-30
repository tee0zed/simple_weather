# frozen_string_literal: true

require 'dotenv'
require 'httparty'
require 'json'

require_relative 'simple_weather/http/providers/base_provider'
require_relative 'simple_weather/http/providers/open_weather'
require_relative 'simple_weather/http/providers/weather_api'
require_relative 'simple_weather/weather_object'
require_relative 'simple_weather/http/handler'
require_relative 'simple_weather/http/request'
require_relative 'simple_weather/errors'

Dotenv.load

module SimpleWeather
  PROVIDERS = {
    weather_api: HTTP::Providers::WeatherApi,
    open_weather: HTTP::Providers::OpenWeather
  }.freeze

  METRICS_SYSTEMS = {
    metric: 'metric',
    imperial: 'imperial'
  }.freeze

  extend self

  def fetch(provider:, units:, request_name:, params:)
    validate_attrs!(request_name:, provider:, units:)

    request = HTTP::Request.new(provider:).call(params, units:, request_name:)
    WeatherObject.new(body: request.body, parse_route: [provider, request_name, units])
  end

  private

  def validate_attrs!(request_name:, provider:, units:)
    raise WrongAttribute unless PROVIDERS.keys.include?(provider)
    raise WrongAttribute unless METRICS_SYSTEMS.values.include?(units.to_s)

    if PROVIDERS[provider].private_instance_methods.grep(request_name).empty?
      raise NoMethodError, "#{request_name} method is missing"
    end
  end
end
