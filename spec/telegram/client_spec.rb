require 'spec_helper'

RSpec.describe Telegram::Client do
  let(:token) { '000:telegram_api_token' }
  let(:http_client) { double('HTTPClient') }
  let(:client) { described_class.new(http_client) }

  before do
    allow(http_client).to receive(:get).and_return(response)
  end

  describe '#get_me' do
    let(:response) { HTTP_RESPONSES[:get_me] }
    let(:result) { client.get_me }
    it 'returns instance of User' do
      expect(result).to be_instance_of(Telegram::User)
    end
  end

  describe '#get_updates' do
    let(:response) { HTTP_RESPONSES[:get_updates] }
    let(:result) { client.get_updates }
    it 'returns array of Update objects' do
      expect(result).to be_instance_of(Array)
      expect(result[0]).to be_instance_of(Telegram::Update)
    end
  end
end
