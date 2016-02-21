require 'spec_helper'

require 'telegram/client'

RSpec.describe Telegram::Client do
  let(:token) { '000:telegram_api_token' }
  let(:json_response) { '{}' }

  describe '#get_me' do
    it 'returns hash' do
      stub_request(:get, "https://api.telegram.org/bot#{token}/getMe")
        .to_return(status: 200, body: json_response)
      client = described_class.new(token)
      response = client.get_me

      expect(response).to be_instance_of(Hash)
    end
  end
end
