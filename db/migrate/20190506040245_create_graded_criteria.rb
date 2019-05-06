class CreateGradedCriteria < ActiveRecord::Migration[5.2]
  def change
    create_table :graded_criteria do |t|
      t.references :graded_rubric, foreign_key: true
      t.text :description
      t.decimal :point
      t.boolean :required
      t.boolean :is_passed
      t.text :comment

      t.timestamps
    end
  end
end
