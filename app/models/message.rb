# == Schema Information
#
# Table name: messages
#
#  id         :integer          not null, primary key
#  body       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  chat_id    :integer          not null
#  sender_id  :integer          not null
#
# Indexes
#
#  index_messages_on_chat_id    (chat_id)
#  index_messages_on_sender_id  (sender_id)
#
# Foreign Keys
#
#  chat_id    (chat_id => chats.id)
#  sender_id  (sender_id => users.id)
#
class Message < ApplicationRecord
  belongs_to :sender, class_name: "User"
  belongs_to :chat
end
