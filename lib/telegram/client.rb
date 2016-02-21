require 'net/http'
require 'json'

module Telegram
  API_HOST = 'api.telegram.org'

  class Client
    def initialize(token)
      @token = token
    end

    def get_me
      Net::HTTP.start(API_HOST, 443, use_ssl: true) do |http|
        response = http.get("/bot#{token}/getMe")
        JSON.parse(response.body)
      end
    end

    private

    attr_reader :token
  end
end
