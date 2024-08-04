class RemoveUserChatFromMessages < ActiveRecord::Migration[7.1]
  def change
    remove_column :messages, :user_chat_id
  end
end
