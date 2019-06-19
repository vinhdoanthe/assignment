class AddSubmitTypeToAssignment < ActiveRecord::Migration[5.2]
  def change
    add_column :assignments, :submit_type, :string
  end
end
