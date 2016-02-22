module Telegram
  class Client
    def initialize(http_client)
      @http_client = http_client
    end

    def get_me
      result = http_client.get("getMe")
      Telegram::User.new(
        result[:id],
        result[:username],
        result[:first_name],
        result[:last_name]
      )
    end

    private

    attr_reader :http_client
  end
end
