# frozen_string_literal: true

class RemoveSenderFromMessages < ActiveRecord::Migration[7.1]
  def change
    remove_column :messages, :sender_id
  end
end
