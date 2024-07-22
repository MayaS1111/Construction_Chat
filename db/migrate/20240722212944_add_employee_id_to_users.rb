class AddEmployeeIdToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :employee_id, :integer
  end
end
