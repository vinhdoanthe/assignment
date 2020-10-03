# frozen_string_literal: true

class SubmissionGradesController < ApplicationController
  include Constants
  include SubmissionGradesHelper
  before_action :set_submission_grade, only: %i[show update destroy]
  before_action :authorized_permission!, only: %i[show update destroy]
  before_action :authorized_admin!, only: %i[destroy index]
  before_action :authorized_granted!, only: [:assigned_submissions]
  after_action :attach_file, only: %i[create update]

  def report_invalid
    # TODO: Is going to implement
  end

  def create_solution
    # TODO: Is going to implement
  end

  def index
    @submission_grades = SubmissionGrade.where(is_latest: true)
  end

  def filter_submissions
  end

  def list_submissions
    respond_to :json, :html
    submissions = SubmissionGrade.where(mentor_id:current_user.id, is_latest:true).to_a
    @course_instances = Hash.new
    unless submissions.nil?
      submissions.each do |submission|
        course_instance = submission.assignment.course_instance
        @course_instances.merge!({course_instance.id => course_instance.code})
      end
    end
    @programs = {}
    unless @course_instances.nil?
      @course_instances.each do |course_instance_id, course_instance_code|
        program = CourseInstance.find(course_instance_id).program
        @programs.merge!({program.id => program.code})
      end
    end
    respond_to do |format|
      unless @programs.nil?
        format.html { render 'list_submissions'}
      end
    end
  end

  def assigned_submissions
    sg_service = SubmissionGradesService.new

    @submissions = sg_service.list_submissions params, current_user
    @status_report = sg_service.status_report current_user
  rescue Exception => e
    p e.inspect
    redirect_to root_path && return
  end

  def show;
  end

  def new_solution
    if params[:assignment_id].present?
      assignment_id = params[:assignment_id]
      assignment = Assignment.find(assignment_id)
      @submission_grade = SubmissionGrade.new(assignment_id: assignment_id,
                                              status: Constants::SUBMISSION_GRADE_STATUS_SUBMITTED,
                                              student_id: current_user.id,
                                              is_latest: true)
      latest_submission = SubmissionGrade.find_by(assignment_id: assignment_id,
                                                  student_id: current_user.id,
                                                  is_latest: true)

      if latest_submission.nil? ||
          (latest_submission.status == Constants::SUBMISSION_GRADE_STATUS_NOT_PASSED &&
           (assignment.max_attempt.zero? ? true :
            latest_submission.attempt < assignment.max_attempt))
      # Do nothing. Student can submit
      elsif latest_submission.status == Constants::SUBMISSION_GRADE_STATUS_PASSED
        flash[:success] = t('submission.latest_passed')
        redirect_to root_path
      else
        flash[:success] = t('submission.latest_being_processed')
        redirect_to root_path
      end
    else
      redirect_to root_path
    end
  end

  def create
    @submission_grade = SubmissionGrade.new(submission_grade_params)
    if student_can_submit?(@submission_grade.assignment_id, current_user.id)
      @submission_grade.attempt = find_attempt(@submission_grade.assignment_id, current_user.id)
      @submission_grade.grade_type = @submission_grade.assignment.grade_type
      respond_to do |format|
        if @submission_grade.save
          SubmissionGradeMailer.submitted_email(current_user, @submission_grade).deliver_later
          format.html {redirect_to active_assignments_path, success: 'Submission grade was successfully created.'}
          format.json {render :show, status: :created, location: @submission_grade}
        else
          format.html {render :new_solution}
          format.json {render json: @submission_grade.errors, status: :unprocessable_entity}
        end
        unless @submission_grade.attempt == 1
          SubmissionGrade.update_latest(@submission_grade.student_id, @submission_grade.assignment_id, @submission_grade.attempt - 1)
        end
      end
    else
      render js: "alert('You do not have permission to perform this action');"
    end
  end

  def destroy
    purge_file
    @submission_grade.destroy
    respond_to do |format|
      format.html {redirect_to submission_grades_url, notice: 'Submission grade was successfully destroyed.'}
      format.json {head :no_content}
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_submission_grade
    @submission_grade = SubmissionGrade.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def submission_grade_params
    params.require(:submission_grade).permit(:assignment_id, :student_id, :status, :submission_file, :is_latest, :is_latest, :mentor_id, :graded_file, :point)
  end

  def attach_file
    unless @submission_grade.submission_file.attached?
      @submission_grade.submission_file.attach(params[:submission_file])
    end
    unless @submission_grade.graded_file.attached?
      @submission_grade.graded_file.attach(params[:graded_file])
    end
  end

  def purge_file
    @submission_grade.submission_file.purge
    @submission_grade.graded_file.purge
  end

  def authorized_admin!
    unless current_user.admin?
      flash.now[:danger] = 'You do not have permission to perform this action'
      redirect_to root_path
    end
  end

  def authorized_permission!
    if current_user.learner?
      if current_user.submission_grades.include?(@submission_grade)

      else
        flash.now[:danger] = 'You do not have permission to perform this action'
        redirect_to root_path
      end
    elsif current_user.admin?
      true
    elsif current_user.mentor?
      @submission_grade.mentor_id == current_user.id
    end
  end

  def authorized_granted!
    unless current_user.mentor? || current_user.admin?
      flash[:danger] = 'You do not have permission to take this action'
      redirect_to root_path
    end
  end
end
