require 'spec_helper'
require 'webmock'

RSpec.describe Telegram::HTTPClient do
  include WebMock::API

  let(:token) { '000:telegram_api_token' }
  let(:client) { described_class.new(token) }

  describe '#get' do
    let(:json_response) { {result: {}}.to_json }

    it 'returns hash' do
      stub_request(:get, api_url(token, 'getMe')).to_return(status: 200, body: json_response)

      response = client.get('getMe')
      expect(response).to be_instance_of(Hash)
    end
  end

  private

  def api_url(token, method)
    "https://#{described_class::API_HOST}/bot#{token}/#{method}"
  end
end
