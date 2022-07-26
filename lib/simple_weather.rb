# frozen_string_literal: true

require 'dotenv'
require 'httparty'
require 'json'

require_relative 'simple_weather/http/request'
require_relative 'simple_weather/exceptions'
require_relative 'simple_weather/version'

Dotenv.load

module SimpleWeather
  module_function

  def fetch(provider:, units:, request_name:, params:)
    request = HTTP::Request.new(provider:, units:, request_name:)
    request.call(params).to_weather
  end
end
