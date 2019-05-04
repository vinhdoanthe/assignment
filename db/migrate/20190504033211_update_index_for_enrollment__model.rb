class UpdateIndexForEnrollmentModel < ActiveRecord::Migration[5.2]
  def change
    add_index :enrollments, [:user_id, :course_instance_id], unique: true
  end
end
