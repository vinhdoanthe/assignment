class CreateEnrollments < ActiveRecord::Migration[5.2]
  def change
    create_table :enrollments do |t|
      t.belongs_to :user, foreign_key: true
      t.belongs_to :course_instance, foreign_key: true
      t.date :start_date
      t.date :end_date
      t.boolean :is_active

      t.timestamps
    end
  end
end
