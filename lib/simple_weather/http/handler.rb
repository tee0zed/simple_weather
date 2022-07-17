# frozen_string_literal: true

module SimpleWeather
  module HTTP
    module Handler
      DEFAULT_SUCCESS_CODE = 200

      def handle(success_code: DEFAULT_SUCCESS_CODE, &request)
        response = request.call
        return response if response.code == success_code

        raise BadResponse, response
      end
    end
  end
end
