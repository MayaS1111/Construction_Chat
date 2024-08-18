# == Schema Information
#
# Table name: user_chats
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  chat_id    :integer          not null
#  user_id    :integer          not null
#
# Indexes
#
#  index_user_chats_on_chat_id  (chat_id)
#  index_user_chats_on_user_id  (user_id)
#
# Foreign Keys
#
#  chat_id  (chat_id => chats.id)
#  user_id  (user_id => users.id)
#
class UserChat < ApplicationRecord
  belongs_to :chat
  belongs_to :user

  accepts_nested_attributes_for :chat, :user

  after_create_commit :add_to_main_chat

  def create_message(added_user, current_user, chat)
    create_bot_user unless User.exists?(id: 0)

    Message.create(body: "#{added_user.name} has been added by #{current_user.name}",  chat_id: chat, sender_id: "0")
  end

  def remove_message(current_user, chat_id)
    create_bot_user unless User.exists?(id: 0)

    if self.user == current_user
      Message.create(body: "#{current_user.name} has left the chat",  chat_id: chat_id , sender_id: "0")
    else
      Message.create(body: "#{self.user.name} has been removed by #{current_user.name}",  chat_id: chat_id , sender_id: "0")
    end
  end

  def create_bot_user
    return if User.exists?(id: 0)

    User.create(id: 0, first_name: "BuiltBetter", last_name: "Bot", phone_number: "0000000000", email: "builtbetter@info.com", job_title: "Helper Bot", password: "password", admin: true, profile_image: "https://api.dicebear.com/9.x/thumbs/svg?seed=Sam&backgroundColor=D2042D&radius=50&eyesColor=000000&mouthColor=000000&shapeColor=ffffff&scale=70")
  end

  private
    def add_to_main_chat
      # TODO: create user_chat for main chat if it doesn't exist
      # unless chat.project.first_chat.members.exist? user
      #   chat.projects.first_chat.user_chats.create(user: user)
      # end
    end
end
