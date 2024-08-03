# == Schema Information
#
# Table name: messages
#
#  id           :integer          not null, primary key
#  body         :text
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  sender_id    :integer          not null
#  user_chat_id :integer
#
# Indexes
#
#  index_messages_on_sender_id  (sender_id)
#
# Foreign Keys
#
#  sender_id     (sender_id => users.id)
#  user_chat_id  (user_chat_id => user_chats.id)
#
class Message < ApplicationRecord
  # validates :body, presence: true

  belongs_to :user_chat
  belongs_to :sender, class_name: "User"
end
