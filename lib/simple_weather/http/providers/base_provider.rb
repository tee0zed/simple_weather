# frozen_string_literal: true

module SimpleWeather
  module HTTP
    module Providers
      class BaseProvider
        attr_accessor :url

        def initialize
          @url = ''
          @metric_units_in_query = false
        end

        def build_url_for(request_name, params, units:)
          send(request_name, **params)
            .with_metric_system(units)
            .with_api_key
            .url
        end

        protected

        def with_metric_system(_units)
          self
        end

        def with_api_key
          url << api_key_param
          self
        end

        private

        # Determines if the provider uses metrics option in query or it comes from body
        def metric_units_in_query?
          @metric_units_in_query
        end

        def both_units_in_response?
          !metric_units_in_query?
        end
      end
    end
  end
end
