ActiveAdmin.register SubmissionGrade do
  controller do
    # belongs_to :user, class_name: 'User', foreign_key: 'student_id', optional: true
    # belongs_to :user, class_name: 'User', foreign_key: 'mentor_id', optional: true
    belongs_to :assignments, optional: true
  end

  show title: :display_name do
    h3 'Detail'
    attributes_table do
      row :assignment
      row :student
      row :status
      row :attempt
      row :submission_file do
        if submission_grade.submission_file.attached?
          link_to('Submission file',
                  rails_blob_path(submission_grade.submission_file, disposition: 'attachment'))
        else
          'N/A'
        end
      end
      row :is_latest
      row :mentor
      row :graded_file do
        if submission_grade.graded_file.attached?
          link_to('Graded file',
                  rails_blob_path(submission_grade.graded_file, disposition: 'attachment'))
        else
          'N/A'
        end
      end
      row :point
      row :graded_rubric
    end
  end
  permit_params :assignment_id, :student_id, :status, :attempt, :is_latest, :mentor_id, :assigned_at, :point, :graded_at
end
