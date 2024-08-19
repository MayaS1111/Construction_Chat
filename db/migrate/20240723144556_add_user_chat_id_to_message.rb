# frozen_string_literal: true

class AddUserChatIdToMessage < ActiveRecord::Migration[7.1]
  def change
    add_column :messages, :user_chat_id, :integer

    add_foreign_key :messages, :user_chats, column: :user_chat_id
  end
end
