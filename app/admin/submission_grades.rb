# frozen_string_literal: true

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

  # Scopes (default filters) for index page
  scope('All latest') {|scope| scope.where(is_latest: true)}
  scope('Submitted') {|scope| scope.where(status: Constants::SUBMISSION_GRADE_STATUS_SUBMITTED, is_latest: true)}
  scope('Assigned') {|scope| scope.where(status: Constants::SUBMISSION_GRADE_STATUS_ASSIGNED, is_latest: true)}
  scope :all

  controller do
    belongs_to :assignments, optional: true

    def assign_mentor; end
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

    actions defaults: false do |resource|
      item 'View', admin_submission_grade_path(resource)
      text_node ' | '
      item 'Assign mentor', assign_mentor_admin_submission_grade_path(resource)
      text_node ' | '
      item 'Edit', edit_admin_submission_grade_path(resource)
    end
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
  permit_params :assignment_id, :student_id,
                :status, :attempt, :is_latest,
                :mentor_id, :assigned_at, :point, :graded_at

  member_action :assign_mentor, method: %i[get post] do
    if request.post?

    else
      render :'admin/submission_grades/assign_mentor',
             locals: {submission_grade: resource}
    end
  end

  action_item :assign_mentor, only: :show do
    link_to 'Assign mentor', assign_mentor_admin_submission_grade_path(self)
  end
end
