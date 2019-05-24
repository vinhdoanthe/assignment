ActiveAdmin.register GradedRubric do
  # menu false
  controller do
    belongs_to :submission_grade, optional: true
  end

  show do
    # panel 'Information' do
    attributes_table do
      row :submission_grade do
        link_to graded_rubric.submission_grade.display_name, admin_submission_grade_path(graded_rubric.submission_grade)
      end
      row :student do
        graded_rubric.submission_grade.student.email
      end
      row :mentor do
        graded_rubric.submission_grade.mentor.nil? ? 'N/A' : graded_rubric.submission_grade.mentor.email
      end

      row :point
      row :comment
    end

    panel 'Graded criteria' do
      table_for graded_rubric.graded_criteriums do
        column :index
        column :description
        column :criteria_type
        column :weight
        column :mandatory
        column :status
        column :point
        column :comment
      end
    end
  end

  permit_params :submission_grade_id, :point, :comment
end
