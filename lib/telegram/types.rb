module Telegram
  define_type 'User' do
    field :id
    field :username
    field :first_name, optional: true
    field :last_name, optional: true
  end

  define_type 'Chat' do
    field :id
    field :type
    field :title, optional: true
    field :username, optional: true
    field :first_name, optional: true
    field :last_name, optional: true
  end

  define_type 'Message' do
    field :message_id
    field :chat, type: 'Chat'
    field :from, type: 'User', optional: true
    field :date
    field :text, optional: true
  end

  define_type 'Update' do
    field :update_id
    field :message, type: 'Message', optional: true
  end
end
