# frozen_string_literal: true

module SimpleWeather
  class WeatherObject
    TEMPERATURE_FIELDS = {
      weather_api: {
        current_weather: {
          imperial: ->(body) { body.dig(*%w[current temp_f]) },
          metric: ->(body) { body.dig(*%w[current temp_c]) }
        },
        history_weather: {
          imperial: ->(body) { body.dig(*%w[forecast forecastday]).first.dig(*%w[day avgtemp_f]) },
          metric: ->(body) { body.dig(*%w[forecast forecastday]).first.dig(*%w[day avgtemp_c]) }
        }
      },
      open_weather: {
        current_weather: {
          imperial: ->(body) { body.dig(*%w[main temp]) },
          metric: ->(body) { body.dig(*%w[main temp]) }
        }
      }
    }.freeze

    attr_reader :body, :parse_route

    def initialize(body:, parse_route:)
      @body = body
      @parse_route = parse_route
    end

    def temperature
      return nil if body.nil?
      return nil if parse_lambda.nil?

      parse_lambda.call(body)
    end

    private

    def parse_lambda
      TEMPERATURE_FIELDS.dig(*parse_route.map(&:to_sym))
    rescue StandardError
      raise Errors::ParseError, parse_route.inspect
    end
  end
end
