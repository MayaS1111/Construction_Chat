# frozen_string_literal: true

class CreateProjects < ActiveRecord::Migration[7.1]
  def change
    create_table :projects do |t|
      t.references :owner, null: false, foreign_key: { to_table: :users }
      t.string :name
      t.text :description
      t.string :location
      t.integer :member_count, default: 0
      t.string :project_type

      t.timestamps
    end
  end
end
