class RefactorModels < ActiveRecord::Migration[5.2]
  def change

    # Program model

    # Course model

    # CourseInstance model
    remove_column :course_instances, :start_date
    remove_column :course_instances, :end_date

    # User model
    remove_column :users, :funid
    remove_column :users, :username

    # Enrollment model

    # Assignment model
    remove_column :assignments, :start_date
    remove_column :assignments, :end_date
    add_column :assignments, :description, :text
    remove_column :assignments, :point
    add_column :assignments, :grade_type, :string

    # Rubric model
    remove_column :rubrics, :rubric_type
    remove_column :rubrics, :status
    remove_column :rubrics, :description

    # CriteriaFormat model
    rename_column :criteria_formats, :max_point, :point
    rename_column :criteria_formats, :weighted, :weight
    rename_column :criteria_formats, :required, :is_required

    # SubmissionGrade model
    rename_column :submission_grades, :is_latest, :attempt
    rename_column :submission_grades, :is_latest, :is_latest
    remove_column :submission_grades, :graded_rubric_id
    add_column :submission_grades, :assigned_at, :datetime
    add_column :submission_grades, :graded_at, :datetime

    # GradedRubric model
    remove_column :graded_rubrics, :rubric_id
    remove_column :graded_rubrics, :rubric_type
    remove_column :graded_rubrics, :status
    remove_column :graded_rubrics, :description

    #GradedCriterium model
    rename_column :graded_criteria, :required, :is_required
    add_column :graded_criteria, :criteria_type, :string
    add_column :graded_criteria, :weight, :decimal

  end
end
