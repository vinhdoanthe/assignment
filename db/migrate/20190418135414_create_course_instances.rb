class CreateCourseInstances < ActiveRecord::Migration[5.2]
  def change
    create_table :course_instances do |t|
      t.string :code
      t.string :name
      t.text :description
      t.date :start_date
      t.date :end_date
      t.belongs_to :program, foreign_key: true
      t.belongs_to :course, foreign_key: true
      t.string :status

      t.timestamps
    end
  end
end
