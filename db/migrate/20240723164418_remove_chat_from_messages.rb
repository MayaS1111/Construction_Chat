class RemoveChatFromMessages < ActiveRecord::Migration[7.1]
  def change
    remove_column :messages, :chat_id
  end
end
