class AddChatIdToMessages < ActiveRecord::Migration[7.1]
  def change
    add_column :messages, :chat_id, :integer

    add_foreign_key :messages, :chats, column: :chat_id
  end
end
