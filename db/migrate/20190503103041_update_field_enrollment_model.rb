class UpdateFieldEnrollmentModel < ActiveRecord::Migration[5.2]
  def change
    rename_column :enrollments, :is_active, :status
    change_column :enrollments, :status, :string
  end
end
