module Telegram
  class Client
    def initialize(http_client)
      @http_client = http_client
    end

    def get_me
      Telegram::User.new(http_client.get("getMe"))
    end

    def get_updates
      result = http_client.get("getUpdates")
      p result
    end

    private

    attr_reader :http_client
  end
end
