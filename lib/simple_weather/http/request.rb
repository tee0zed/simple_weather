# frozen_string_literal: true

module SimpleWeather
  module HTTP
    class Request
      include Handler
      include HTTParty

      attr_reader :provider
      attr_accessor :body

      def initialize(provider: :weather_api)
        @provider = ::SimpleWeather::PROVIDERS[provider.to_sym].new
      end

      def call(params, request_name:, units:)
        response = handle { self.class.get(url(request_name, params, units:)) }

        self.body = JSON.parse(response.body)
        self
      end

      private

      def request_name
        PROVIDERS.key provider.class
      end

      def url(request_name, params, units:)
        provider.build_url_for(request_name, params, units:)
      end
    end
  end
end
