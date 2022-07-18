# frozen_string_literal: true

require 'httparty'

require_relative 'handler'
require_relative 'weather_object'
require_relative 'providers/open_weather'
require_relative 'providers/weather_api'

module SimpleWeather
  module HTTP
    class Request
      include Handler
      include HTTParty

      PROVIDERS = {
        weather_api: Providers::WeatherApi,
        open_weather: Providers::OpenWeather
      }.freeze

      METRICS_SYSTEMS = {
        metric: 'metric',
        imperial: 'imperial'
      }.freeze

      attr_reader :provider, :provider_name, :units
      attr_accessor :request_name, :body

      def initialize(request_name:, provider: :weather_api, units: :imperial)
        raise ArgumentError unless PROVIDERS.keys.include?(provider)
        raise ArgumentError unless METRICS_SYSTEMS.values.include?(units.to_s)

        @provider = PROVIDERS[provider].new
        @provider_name = provider.to_sym
        @units = units.to_sym
        @request_name = request_name.to_sym
      end

      def call(params:) # rubocop:disable Metrics/AbcSize
        raise ArgumentError unless params && request_name
        raise NoMethodError, "#{request_name} missing" unless provider.private_methods.grep(request_name).any?

        url = provider.build_url_for(request_name, params, units:)

        response = handle { self.class.get(url) }

        self.body = JSON.parse(response.body)
        self
      end

      def to_weather
        WeatherObject.new(request: self)
      end
    end
  end
end
