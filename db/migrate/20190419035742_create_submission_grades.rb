class CreateSubmissionGrades < ActiveRecord::Migration[5.2]
  def change
    create_table :submission_grades do |t|
      t.belongs_to :assignment, foreign_key: true
      t.references :student, foreign_key: true
      t.string :submission_status
      t.references :submission_file, foreign_key: true
      t.integer :attempt_count
      t.boolean :latest
      t.references :mentor, foreign_key: true
      t.string :grade_status
      t.belongs_to :graded_rubric, foreign_key: true
      t.references :graded_file, foreign_key: true
      t.decimal :point

      t.timestamps
    end
  end
end
