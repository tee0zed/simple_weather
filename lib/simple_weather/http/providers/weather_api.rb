# frozen_string_literal: true

require_relative 'base_provider'

module SimpleWeather
  module HTTP
    module Providers
      class WeatherApi < BaseProvider
        def current_weather(lat:, lon:)
          self.url = "#{base_url}/current.json?#{coords_query(lat, lon)}"
          self
        end

        def history_weatherx
          self.url = "#{base_url}/history.json?#{coords_query(lat, lon)}&#{date_query(date)}"
          self
        end

        private

        def coords_query(lat, lon)
          "q=#{lat.to_f},#{lon.to_f}"
        end

        def date_query(date)
          "dt=#{date.to_i}"
        end

        def base_url
          @base_url ||= ENV['WEATHER_API_BASE_URL']
        end

        def api_key_param
          @api_key_param ||= "&key=#{ENV['WEATHER_API_KEY']}"
        end
      end
    end
  end
end
