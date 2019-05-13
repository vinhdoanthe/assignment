ActiveAdmin.register SubmissionGrade do
  menu priority: 1
  config.per_page = [10, 50, 100]

  # Filters for index page
  filter :status, as: :select
  filter :is_latest, as: :check_boxes
  filter :assignment
  filter :student_email, as: :string, filters: [:contains]
  filter :created_at
  filter :mentor_email, as: :string, filters: [:contains]
  filter :assigned_at
  filter :graded_at
  # filter :assignment_grade_type, as: :select

  # Scopes (default filters) for index page
  scope('All latest') { |scope| scope.where(is_latest: true) }
  scope('Submitted') { |scope| scope.where(status: Constants::SUBMISSION_GRADE_STATUS_SUBMITTED, is_latest: true) }
  scope('Assigned') { |scope| scope.where(status: Constants::SUBMISSION_GRADE_STATUS_ASSIGNED, is_latest: true) }
  # scope('Need interview') { |scope| scope.where(is_latest: true, grade_type: Constants::ASSIGNMENT_GRADE_TYPE_INTERVIEW) }
  scope :all

  controller do
    # belongs_to :user, class_name: 'User', foreign_key: 'student_id', optional: true
    # belongs_to :user, class_name: 'User', foreign_key: 'mentor_id', optional: true
    belongs_to :assignments, optional: true
  end

  index do
    selectable_column
    id_column
    column :assignment
    column :attempt
    column :is_latest
    column :status
    column :student
    column :created_at
    column :mentor
    column :assigned_at
    column :point
    column :graded_at
    column :grade_type
    actions
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
