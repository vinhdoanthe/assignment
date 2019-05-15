# frozen_string_literal: true

class SubmissionGradesController < ApplicationController
  include Constants
  include SubmissionGradesHelper
  before_action :set_submission_grade, :authorized_permission!, only: %i[show edit update destroy]
  before_action :authorized_admin!, only: %i[edit destroy index]
  before_action :authorized_granted!, only: [:assigned_submissions]
  after_action :attach_file, only: %i[create update]

  def index
    @submission_grades = SubmissionGrade.where(is_latest: true)
  end

  def assigned_submissions
    # @assigned_submissions = SubmissionGrade.where(mentor_id: current_user.id, status: SUBMISSION_GRADE_STATUS_ASSIGNED, is_latest: true).or(SubmissionGrade.where(mentor_id: current_user.id, status: SUBMISSION_GRADE_STATUS_SUBMITTED, is_latest: true))
    @filterrific = initialize_filterrific(
        SubmissionGrade,
        params[:filterrific],
        select_options: {
            sorted_by: SubmissionGrade.options_for_sorted_by,
            with_status: SubmissionGrade.options_for_select,
        },
        persistence_id: "shared_key",
        default_filter_params: {},
        available_filters: [:sorted_by, :with_status],
        sanitize_params: true,
    ) || return
    @assigned_submissions = @filterrific.find.page(params[:page])
    respond_to do |format|
      format.html
      format.js
    end

  rescue ActiveRecord::RecordNotFound => e
    # There is an issue with the persisted param_set. Reset it.
    puts "Had to reset filterrific params: #{e.message}"
    redirect_to(reset_filterrific_url(format: :html)) && return
    # @assigned_submissions = SubmissionGrade.where(mentor_id: current_user.id)
  end

  def grade
    if params[:submission_id].present?
      @submission_grade = SubmissionGrade.find(params[:submission_id])
      authorized_permission!
    else
      flash[:notice] = "Submission does not existed!"
      redirect_to root_path
    end
  end

  def update_grade
    @submission_grade = SubmissionGrade.find(params[:submission_id])
    authorized_permission!
    @submission_grade.point = params[:submission_grade][:point]
    if params[:submission_grade][:point].present?
      if @submission_grade.point < 8
        @submission_grade.status = Constants::SUBMISSION_GRADE_STATUS_NOTPASSED
      else
        @submission_grade.status = Constants::SUBMISSION_GRADE_STATUS_PASSED
      end
    else
      ## Do nothing here (maybe Todo for authorization)
    end
    respond_to do |format|
      if @submission_grade.save
        format.html {redirect_to @submission_grade, notice: 'Submission grade was successfully created.'}
        format.json {render :show, status: :created, location: @submission_grade}
      else
        format.html {render :new}
        format.json {render json: @submission_grade.errors, status: :unprocessable_entity}
      end
    end
  end

# GET /submission_grades/1
# GET /submission_grades/1.json
  def show;
  end

# GET /submission_grades/new
  def new
    @submission_grade = SubmissionGrade.new
    init_submission_grade
    if params[:assignment].present?
      latest_submission = SubmissionGrade.where(:assignment_id => params[:assignment], :is_latest => true).first
      if latest_submission.nil?
        @submission_grade.assignment = Assignment.find(params[:assignment])
      elsif latest_submission.status == Constants::SUBMISSION_GRADE_STATUS_NOTPASSED
        @submission_grade.assignment = Assignment.find(params[:assignment])
      else
        redirect_to active_assignments_path
      end
    end
  end

  def edit;
  end

  def create
    @submission_grade = SubmissionGrade.new(submission_grade_params)
    if student_can_submit?(@submission_grade.assignment_id, current_user.id)
      @submission_grade.attempt = find_attempt(@submission_grade.assignment_id, current_user.id)
      respond_to do |format|
        if @submission_grade.save
          format.html {redirect_to active_assignments_path, notice: 'Submission grade was successfully created.'}
          format.json {render :show, status: :created, location: @submission_grade}
          # redirect_to active_assignments_path
        else
          format.html {render :new}
          format.json {render json: @submission_grade.errors, status: :unprocessable_entity}
        end
        unless @submission_grade.attempt == 1
          SubmissionGrade.update_latest(@submission_grade.student_id, @submission_grade.assignment_id, @submission_grade.attempt - 1)
        end
        SubmissionGrade.create_graded_rubric(@submission_grade.id)
        SubmissionGradeMailer.submitted_email(current_user, @submission_grade).deliver
      end
    else
      render js: "alert('You do not have permission to perform this action');"
    end
  end

# PATCH/PUT /submission_grades/1
# PATCH/PUT /submission_grades/1.json
  def update
    respond_to do |format|
      if @submission_grade.update(submission_grade_params)
        format.html {redirect_to @submission_grade, notice: 'Submission grade was successfully updated.'}
        format.json {render :show, status: :ok, location: @submission_grade}
      else
        format.html {render :edit}
        format.json {render json: @submission_grade.errors, status: :unprocessable_entity}
      end
    end
  end

# DELETE /submission_grades/1
# DELETE /submission_grades/1.json
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
  def graded_criteriums_params
    # params[:submission_grade][:graded_rubric][:]
    params.require(:submission_grade).permit(:graded_rubric => [{:graded_criteriums_attributes => [:index, :description, :required, :point, :comment, :status]}])
  end

  def graded_rubric_params
    params.require(:submission_grade).permit(:graded_rubric => [:comment])
  end

  def submission_grade_params
    params.require(:submission_grade).permit(:assignment_id, :student_id, :status, :submission_file, :is_latest, :is_latest, :mentor_id, :graded_file, :point)
  end

# def permit_grade_params
#   params.require(:submission_grade).permit(:attach_file, :comment, :graded_rubric => [{:graded_criteriums_attributes => [:comment, :status]}])
# end

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
      flash.now[:notice] = 'You do not have permission to perform this action'
      redirect_to root_path
    end
  end

  def authorized_permission!
    if current_user.learner?
      if current_user.submission_grades.include?(@submission_grade)

      else
        flash.now[:notice] = 'You do not have permission to perform this action'
        redirect_to root_path
      end
    elsif current_user.admin?
      true
    elsif current_user.mentor?
      @submission_grade.mentor_id == current_user.id
    else

    end

  end

  def init_submission_grade
    @submission_grade.status = Constants::SUBMISSION_GRADE_STATUS_SUBMITTED
    @submission_grade.student_id = current_user.id
    @submission_grade.is_latest = true
    @submission_grade.mentor_id = nil
    @submission_grade.point = 0
  end

  def authorized_granted!
    unless current_user.mentor? || current_user.admin?
      flash[:notice] = 'You do not have permission to take this action'
      redirect_to root_path
    end
  end

end