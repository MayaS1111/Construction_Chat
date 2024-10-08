# frozen_string_literal: true

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

  def create_message(added_user, current_user, chat)
    create_bot_user unless User.exists?(id: 0)

    Message.create(body: "#{added_user.name} has been added by #{current_user.name}", chat_id: chat, sender_id: '0')
  end

  def remove_message(current_user, chat_id)
    create_bot_user unless User.exists?(id: 0)

    if user == current_user
      Message.create(body: "#{current_user.name} has left the chat", chat_id:, sender_id: '0')
    else
      Message.create(body: "#{user.name} has been removed by #{current_user.name}", chat_id:,
                     sender_id: '0')
    end
  end

  # This is temporary! Render does not re-run seed files. This will be removed when deploying the app again.
  def create_bot_user
    return if User.exists?(id: 0)

    User.create!(id: 0, first_name: 'BuiltBetter', last_name: 'Bot', phone_number: '(000)000-0000',
                 email: 'builtbetter@info.com', job_title: 'Helper Bot', password: 'password', admin: 'true', profile_image: 'https://api.dicebear.com/9.x/thumbs/svg?seed=Sam&radius=50&scale=70&shapeColor=000000&backgroundColor=D2042D')
  end
end
