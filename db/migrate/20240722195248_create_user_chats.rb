# frozen_string_literal: true

class CreateUserChats < ActiveRecord::Migration[7.1]
  def change
    create_table :user_chats do |t|
      t.references :chat, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
