# == Schema Information
#
# Table name: messages
#
#  id         :integer          not null, primary key
#  body       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  chat_id    :integer
#  sender_id  :integer          not null
#
# Indexes
#
#  index_messages_on_sender_id  (sender_id)
#
# Foreign Keys
#
#  chat_id    (chat_id => chats.id)
#  sender_id  (sender_id => users.id)
#
class Message < ApplicationRecord
  # validates :body, presence: true

  belongs_to :user_chat
  belongs_to :sender, class_name: "User"
end
