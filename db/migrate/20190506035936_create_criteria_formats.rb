class CreateCriteriaFormats < ActiveRecord::Migration[5.2]
  def change
    create_table :criteria_formats do |t|
      t.references :rubric, foreign_key: true
      t.text :description
      t.decimal :point
      t.boolean :required

      t.timestamps
    end
  end
end
