# == Schema Information
#
# Table name: messages
#
#  id           :integer          not null, primary key
#  body         :text
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  chat_id      :integer          not null
#  user_chat_id :integer
#
# Indexes
#
#  index_messages_on_chat_id  (chat_id)
#
# Foreign Keys
#
#  chat_id       (chat_id => chats.id)
#  user_chat_id  (user_chat_id => user_chats.id)
#
class Message < ApplicationRecord
  belongs_to :user_chat
end
