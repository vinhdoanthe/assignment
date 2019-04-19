class CreateAssignments < ActiveRecord::Migration[5.2]
  def change
    create_table :assignments do |t|
      t.string :name
      t.date :start_date
      t.date :end_date
      t.decimal :point
      t.belongs_to :course_instance, foreign_key: true
      t.string :status
      t.integer :max_attempt

      t.timestamps
    end
  end
end
