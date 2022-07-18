# frozen_string_literal: true

module SimpleWeather
  module Exceptions
    class Error < StandardError; end
    class ParseError < Error; end
    class BadResponse < Error
      attr_reader :response

      def initialize(response)
        @response = response
        super(response)
      end
    end
  end
end
