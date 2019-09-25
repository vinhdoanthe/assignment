class UpdateFieldAssignmentModel < ActiveRecord::Migration[5.2]
  def change
    rename_column :assignments, :status, :assignment_status
  end
end
