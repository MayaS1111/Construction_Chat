class CreateChats < ActiveRecord::Migration[7.1]
  def change
    create_table :chats do |t|
      t.string :name
      t.text :description
      t.references :project, null: false, foreign_key: { to_table: :projects }
      

      t.timestamps
    end
  end
end
