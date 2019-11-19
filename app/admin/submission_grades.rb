# frozen_string_literal: true

ActiveAdmin.register SubmissionGrade do
  menu priority: 1
  config.per_page = [200, 100, 50, 25]

  # Filters for index page
  filter :status, as: :select
  filter :attempt, as: :select, input_html: {multiple: true}
  filter :course_instance, as: :searchable_select
  filter :assignment, as: :searchable_select
  filter :student, as: :searchable_select
  filter :mentor, as: :searchable_select
  filter :created_at
  filter :assigned_at
  filter :graded_at

  # Scopes (default filters) for index page
  scope('Due') do |scope|
    scope.where('status = ? AND is_latest = ? AND assigned_at < ?',
                Constants::SUBMISSION_GRADE_STATUS_ASSIGNED,
                true,
                Time.now - Settings[:submission][:due_after])
  end
  scope('Assigned') {|scope| scope.where(status: Constants::SUBMISSION_GRADE_STATUS_ASSIGNED, is_latest: true)}
  scope('Submitted') {|scope| scope.where(status: Constants::SUBMISSION_GRADE_STATUS_SUBMITTED, is_latest: true)}
  scope :all

  csv do
    column('instance') {|submission_grade| submission_grade.assignment.course_instance.code}
    column('assignment') {|submission_grade| submission_grade.assignment.name}
    column('student email') {|submission_grade| submission_grade.student.email}
    column('mentor email') {|submission_grade| submission_grade.mentor.nil? ? '' : submission_grade.mentor.email}
    column('type') {|submission_grade| submission_grade.attempt == 1 ? 'new' : 're_grade'}
    column('grade status') {|submission_grade| submission_grade.status}
    column('point') {|submission_grade| submission_grade.point}
    column('created at') {|submission_grade| submission_grade.created_at}
    column('graded at') {|submission_grade| submission_grade.graded_at}
  end
  controller do
    belongs_to :assignments, optional: true
  end

  index do
    selectable_column
    id_column
    column :course_instance
    column(:assignment) {|resource| resource.assignment.name}
    column :attempt
    # column :is_latest
    column :status
    column :student
    column(:created_at) {|resource| resource.created_at.nil? ? '' : resource.created_at.strftime("%H:%M:%S %d-%m-%Y")}
    column :mentor
    column(:assigned_at) {|resource| resource.assigned_at.nil? ? '' : resource.assigned_at.strftime("%H:%M:%S %d-%m-%Y")}
    column :point
    # column :graded_at
    column :grade_type

    actions defaults: false do |resource|
      item 'View', admin_submission_grade_path(resource)

      if current_user.admin? and resource.status == Constants::SUBMISSION_GRADE_STATUS_SUBMITTED
        text_node ' | '
        item 'Assign', assign_mentor_admin_submission_grade_path(resource)
      end
      if current_user.admin? and resource.status == Constants::SUBMISSION_GRADE_STATUS_ASSIGNED
        text_node ' | '
        item 'Re-Assign', assign_mentor_admin_submission_grade_path(resource)
      end
    end
  end

  show do
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
    submission_grade = SubmissionGrade.find(params[:id])
    if request.post?
      submission_grade.mentor_id = params[:submission_grade][:mentor_id]
      submission_grade.status = submission_grade.mentor.nil? ? Constants::SUBMISSION_GRADE_STATUS_SUBMITTED : Constants::SUBMISSION_GRADE_STATUS_ASSIGNED
      submission_grade.assigned_at = Time.now
      submission_grade.save
      SubmissionGradeMailer.assigned_mentor_email(submission_grade.mentor_id,
                                                  submission_grade).deliver_later
      redirect_to admin_submission_grade_path(submission_grade)
    else
      render :'admin/submission_grades/assign_mentor',
             locals: {submission_grade: submission_grade}
    end
  end

  member_action :take_back, method: :post do
    submission_grade = SubmissionGrade.find(params[:id])
    submission_grade.mentor_id = nil
    submission_grade.assigned_at = nil
    submission_grade.status = Constants::SUBMISSION_GRADE_STATUS_SUBMITTED
    submission_grade.save!
    redirect_to admin_submission_grade_path(submission_grade)
  end

  action_item :take_back, only: :show do
    if current_user.admin?
      submission_grade = SubmissionGrade.find(params[:id])
      if submission_grade.status == Constants::SUBMISSION_GRADE_STATUS_ASSIGNED
        link_to 'Take Back', take_back_admin_submission_grade_path, {:id => submission_grade.id, :method => :post}
      end
    end
  end

  action_item :assign_mentor, only: :show do
    if current_user.admin?
      submission_grade = SubmissionGrade.find(params[:id])
      if submission_grade.status != Constants::SUBMISSION_GRADE_STATUS_PASSED and submission_grade.status != Constants::SUBMISSION_GRADE_STATUS_NOT_PASSED
        link_to 'Assign mentor', assign_mentor_admin_submission_grade_path(submission_grade)
      end
    end
  end

  action_item :reset_submission, only: :show do
    if current_user.admin?
      submission_grade = SubmissionGrade.find(params[:id])
      if submission_grade.status != Constants::SUBMISSION_GRADE_STATUS_PASSED and submission_grade.status != Constants::SUBMISSION_GRADE_STATUS_NOT_PASSED
        link_to 'Reset Submission', reset_submission_admin_submission_grade_path(params[:id]),
                {:id => submission_grade.id, :method => :post, :data => {confirm: I18n.t('assignment.submission_grade.message.confirm_reset_submit')}}
      end
    end
  end

  member_action :reset_submission, method: :post do
    submission_grade = SubmissionGrade.find(params[:id])
    if submission_grade.attempt > 1
      prev_submission = SubmissionGrade.where(student_id: submission_grade.student_id, assignment_id: submission_grade.assignment_id, attempt: submission_grade.attempt-1).first
      puts prev_submission
      prev_submission.is_latest = true
      prev_submission.save
    end
    submission_grade.destroy!
    redirect_to admin_submission_grades_path
  end

  batch_action :assign_mentor, form: -> {{user: User.where(role: Constants::USER_ROLE_MENTOR).pluck(:email, :id)}} do |ids, inputs|
    batch_action_collection.find(ids).each do |submission_grade|
      mentor = User.find(inputs[:user])
      submission_grade.mentor_id = mentor.id
      submission_grade.status = submission_grade.mentor.nil? ? Constants::SUBMISSION_GRADE_STATUS_SUBMITTED : Constants::SUBMISSION_GRADE_STATUS_ASSIGNED
      submission_grade.assigned_at = Time.now
      submission_grade.save
      SubmissionGradeMailer.assigned_mentor_email(submission_grade.mentor_id,
                                                  submission_grade).deliver_later
    end
    redirect_to admin_submission_grades_path
  end
end