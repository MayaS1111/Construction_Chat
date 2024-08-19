# frozen_string_literal: true

class AddStausToProjects < ActiveRecord::Migration[7.1]
  def change
    add_column :projects, :status, :string
  end
end
