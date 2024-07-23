# == Schema Information
#
# Table name: messages
#
#  id           :integer          not null, primary key
#  body         :text
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  user_chat_id :integer
#
# Foreign Keys
#
#  user_chat_id  (user_chat_id => user_chats.id)
#
class Message < ApplicationRecord
  belongs_to :user_chat
  belongs to :sender, class_name: "User"
end
