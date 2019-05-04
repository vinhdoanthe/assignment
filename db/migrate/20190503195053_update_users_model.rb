class UpdateUsersModel < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :type
    add_column :users, :username, :string
    add_index :users, [:username, :funid]
  end
end
