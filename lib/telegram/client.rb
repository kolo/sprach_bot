module Telegram
  class Client
    def initialize(http_client)
      @http_client = http_client
    end

    def get_me
      User.new(http_client.get("getMe"))
    end

    def get_updates
      Update.array(http_client.get("getUpdates"))
    end

    private

    attr_reader :http_client
  end
end
