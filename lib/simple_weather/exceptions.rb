# frozen_string_literal: true

module SimpleWeather
  class Error < StandardError; end

  class BadResponse < Error
    attr_reader :response

    def initialize(response)
      @response = response
      super(response)
    end
  end
end
