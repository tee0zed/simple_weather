# frozen_string_literal: true

module SimpleWeather
  module HTTP
    class WeatherObject
      extend Forwardable

      TEMPERATURE_FIELDS = {
        weather_api: {
          current_weather: {
            imperial: %w[current temp_f],
            metric: %w[current temp_c]
          },
          history_weather: {
            imperial: %w[history temp_f],
            metric: %w[history temp_c]
          }
        },
        open_weather: {
          current_weather: {
            imperial: %w[main temp],
            metric: %w[main temp]
          },
          history_weather: {
            imperial: %w[main temp],
            metric: %w[main temp]
          }
        }
      }.freeze

      def_delegators :@request, :provider_name, :request_name, :units, :body

      def initialize(request:)
        @request = request
      end

      def temperature
        return nil if body.nil?
        return nil if parse_route.nil?

        body.dig(*parse_route)
      end

      private

      def parse_route
        TEMPERATURE_FIELDS.dig(provider_name, request_name, units)
      rescue StandardError
        TypeError
      end
    end
  end
end
