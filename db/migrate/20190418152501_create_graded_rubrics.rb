class CreateGradedRubrics < ActiveRecord::Migration[5.2]
  def change
    create_table :graded_rubrics do |t|
      t.belongs_to :rubric, foreign_key: true
      t.integer :type
      t.string :status
      t.decimal :point
      t.text :cr1_des
      t.decimal :cr1_score
      t.boolean :cr1_enable
      t.text :cr2_des
      t.decimal :cr2_score
      t.boolean :cr2_enable
      t.text :cr3_des
      t.decimal :cr3_score
      t.boolean :cr3_enable
      t.text :cr4_des
      t.decimal :cr4_score
      t.boolean :cr4_enable
      t.text :cr5_des
      t.decimal :cr5_score
      t.boolean :cr5_enable
      t.text :cr6_des
      t.decimal :cr6_score
      t.boolean :cr6_enable
      t.text :cr7_des
      t.decimal :cr7_score
      t.boolean :cr7_enable
      t.text :cr8_des
      t.decimal :cr8_score
      t.boolean :cr8_enable
      t.text :cr9_des
      t.decimal :cr9_score
      t.boolean :cr9_enable
      t.text :cr10_des
      t.decimal :cr10_score
      t.boolean :cr10_enable
      t.text :cr11_des
      t.decimal :cr11_score
      t.boolean :cr11_enable
      t.text :cr12_des
      t.decimal :cr12_score
      t.boolean :cr12_enable
      t.text :cr13_des
      t.decimal :cr13_score
      t.boolean :cr13_enable
      t.text :cr14_des
      t.decimal :cr14_score
      t.boolean :cr14_enable
      t.text :cr15_des
      t.decimal :cr15_score
      t.boolean :cr15_enable
      t.text :cr16_des
      t.decimal :cr16_score
      t.boolean :cr16_enable

      t.timestamps
    end
  end
end
