module SimpleWeather
  module HTTP
    class WeatherObject
      extend Forwardable

      TEMPERATURE_FIELDS = {
        weather_api: {
          current_weather: {
            imperial: ->(body) { body.dig *%w[current temp_f] },
            metric: ->(body) { body.dig *%w[current temp_c] }
          },
          history_weather: {
            imperial: ->(body) { body.dig(*%w[forecast forecastday]).first.dig(*%w[day avgtemp_f]) },
            metric: ->(body) { body.dig(*%w[forecast forecastday]).first.dig(*%w[day avgtemp_c]) }
          }
        },
        open_weather: {
          current_weather: {
            imperial: ->(body) { body.dig *%w[main temp] },
            metric: ->(body) { body.dig *%w[main temp] },
          }
        }
      }.freeze

      def_delegators :@request, :provider_name, :request_name, :units, :body

      def initialize(request:)
        @request = request
      end

      def temperature
        return nil if body.nil?
        return nil if parse_lambda.nil?

        parse_lambda.call(body)
      end

      private

      def parse_lambda
        TEMPERATURE_FIELDS.dig(*[provider_name, request_name, units].map(&:to_sym))
      rescue StandardError
        TypeError.new("#{provider_name} #{request_name} #{units}")
      end
    end
  end
end
