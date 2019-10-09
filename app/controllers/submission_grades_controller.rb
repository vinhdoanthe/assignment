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

  def assigned_submissions
    @filterrific = initialize_filterrific(
      SubmissionGrade.filtered_by_mentor_id(current_user.id),
      params[:filterrific],
      select_options: {
        sorted_by: SubmissionGrade.options_for_sorted_by,
        with_status: SubmissionGrade.options_for_select
      },
      persistence_id: 'submission_grades_assigned_submissions',
      default_filter_params: {},
      available_filters: %i[sorted_by with_status],
      sanitize_params: true
    ) || return
    @assigned_submissions = @filterrific.find.page(params[:page]).per_page(20)
    respond_to do |format|
      format.html
      format.js
    end
  rescue ActiveRecord::RecordNotFound => e
    # There is an issue with the persisted param_set. Reset it.
    puts "Had to reset filterrific params: #{e.message}"
    redirect_to(reset_filterrific_url(format: :html)) && return
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
      respond_to do |format|
        if @submission_grade.save
          SubmissionGradeMailer.submitted_email(current_user, @submission_grade).deliver_later
          format.html { redirect_to active_assignments_path, success: 'Submission grade was successfully created.' }
          format.json { render :show, status: :created, location: @submission_grade }
        else
          format.html { render :new_solution }
          format.json { render json: @submission_grade.errors, status: :unprocessable_entity }
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
      format.html { redirect_to submission_grades_url, notice: 'Submission grade was successfully destroyed.' }
      format.json { head :no_content }
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

  #
  # def init_submission_grade
  #   @submission_grade.status = Constants::SUBMISSION_GRADE_STATUS_SUBMITTED
  #   @submission_grade.student_id = current_user.id
  #   @submission_grade.is_latest = true
  #   @submission_grade.mentor_id = nil
  #   @submission_grade.point = 0
  # end

  def authorized_granted!
    unless current_user.mentor? || current_user.admin?
      flash[:danger] = 'You do not have permission to take this action'
      redirect_to root_path
    end
  end
end
