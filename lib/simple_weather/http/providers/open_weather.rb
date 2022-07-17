# frozen_string_literal: true

require_relative 'base_provider'

module SimpleWeather
  module HTTP
    module Providers
      class OpenWeather < BaseProvider
        def initialize
          super
          @metric_units_in_query = true
        end

        def current_weather(lat:, lon:)
          self.url = "#{base_url}/weather?#{coords_query(lat, lon)}"
          self
        end

        def history_weather(lat:, lon:, date:)
          self.url = "#{base_url}/history?#{coords_query(lat, lon)}&#{date_query(date)}"
          self
        end

        def with_metric_system(units)
          url << "&units=#{units}"
          self
        end

        private

        def coords_query(lat, lon)
          "lat=#{lat.to_f}&lon=#{lon.to_f}"
        end

        def date_query(date)
          "dt=#{date.to_i}"
        end

        def base_url
          @base_url ||= ENV['OPEN_WEATHER_BASE_URL']
        end

        def api_key_param
          @api_key_param ||= "&appid=#{ENV['OPEN_WEATHER_KEY']}"
        end
      end
    end
  end
end
