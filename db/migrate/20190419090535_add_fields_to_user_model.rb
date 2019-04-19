class AddFieldsToUserModel < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :role, :string
    add_column :users, :status, :string
    add_column :users, :full_name, :string
  end
end
