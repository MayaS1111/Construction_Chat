# frozen_string_literal: true

class AddSenderIdToMessage < ActiveRecord::Migration[7.1]
  def change
    add_reference :messages, :sender, null: false, foreign_key: { to_table: :users }
  end
end
