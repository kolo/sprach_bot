require 'spec_helper'

RSpec.describe Telegram::Client do
  let(:token) { '000:telegram_api_token' }
  let(:http_client) { double('HTTPClient') }
  let(:client) { described_class.new(http_client) }

  describe '#get_me' do
    let(:result) { { id: 181935498, username: 'sprach_bot' } }
    it 'returns instance of User' do
      allow(http_client).to receive(:get).and_return(result)

      user = client.get_me

      expect(user).to be_instance_of(Telegram::User)
      expect(user.id).to eq result[:id]
      expect(user.username).to eq result[:username]
    end
  end
end
