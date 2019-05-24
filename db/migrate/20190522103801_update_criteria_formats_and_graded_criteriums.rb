class UpdateCriteriaFormatsAndGradedCriteriums < ActiveRecord::Migration[5.2]
  def change
    rename_column :criteria_formats, :description, :criteria_description
    add_column :criteria_formats, :outcome, :string
    add_column :criteria_formats, :meet_the_specification, :text
    rename_column :criteria_formats, :is_required, :mandatory

    rename_column :graded_criteria, :description, :criteria_description
    add_column :graded_criteria, :outcome, :string
    add_column :graded_criteria, :meet_the_specification, :text
    rename_column :graded_criteria, :is_required, :mandatory
  end
end
