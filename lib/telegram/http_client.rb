require 'net/http'
require 'json'

module Telegram
  class HTTPClient
    API_HOST = 'api.telegram.org'

    def initialize(token)
      @token = token
    end

    def get(method)
      result = nil
      Net::HTTP.start(API_HOST, 443, use_ssl: true) do |http|
        response = http.get(endpoint(method))
        result = JSON.parse(response.body)['result']
      end

      result
    end

    private

    attr_reader :token

    def endpoint(method)
      "/bot#{token}/#{method}"
    end
  end
end
