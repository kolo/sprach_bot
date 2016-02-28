require 'spec_helper'

RSpec.describe Telegram::Type do
  let(:class_name) { 'Note' }
  let(:klass) { Telegram.const_get(class_name) }

  before do
    Telegram.define_type(class_name) do
      field :title
      field :text, optional: true
      field :author, type: 'User'
    end
  end

  let(:attributes) do
    {
      title: 'Sticky note',
      text: 'This note is sticky',
      author: {
        id: 181935678,
        username: 'sprach_bot'
      }
    }
  end

  describe 'an instance of user defined type' do

    it 'has defined fields' do
      instance_methods= Telegram.const_get(class_name).instance_methods
      expect(instance_methods).to include(:title, :text)
    end

    it 'raises error if required field is not set' do
      expect { klass.new }.to raise_error ArgumentError
    end

    it 'has values for given properties' do
      obj = klass.new(attributes)
      expect(obj.title).to eq attributes[:title]
      expect(obj.text).to eq attributes[:text]
      expect(obj.author).to be_instance_of(Telegram::User)
    end
  end

  describe '.array' do
    let(:result) { klass.array([attributes]) }

    it 'returns array of object' do
      expect(result).to be_instance_of(Array)
      expect(result[0]).to be_instance_of(klass)
    end
  end

  after(:each) do
    Telegram.send(:remove_const, class_name)
  end
end
