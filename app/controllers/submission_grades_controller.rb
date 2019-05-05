# frozen_string_literal: true

class SubmissionGradesController < ApplicationController
  include Constants
  include SubmissionGradesHelper
  include SmartListing::Helper::ControllerExtensions
  helper SmartListing::Helper
  before_action :set_submission_grade, :authorized_permission!, only: %i[show edit update destroy]
  before_action :authorized_admin!, only: %i[edit destroy index]
  before_action :authorized_granted!, only: [:assigned_submissions]
  after_action :attach_file, only: %i[create update]
  # before_action :authorized_permission!, only: %i[show edit update destroy]
  # before_action :purge_file, only: [:destroy]
  # before_action :update_latest, only: [:create]
  # before_action :set_submission_grade, :update_latest, only: [:update]
  # before_action :change_submission_status, only: [:update]
  # GET /submission_grades
  # GET /submission_grades.json
  def index
    @submission_grades = SubmissionGrade.where(latest: true)
  end

  def assigned_submissions
    @assigned_submissions = SubmissionGrade.where(mentor_id: current_user.id, submission_status: SUBMISSION_GRADE_STATUS_ASSIGNED, latest: true).or(SubmissionGrade.where(mentor_id: current_user.id, submission_status: SUBMISSION_GRADE_STATUS_SUBMITTED, latest: true))
  end

  def grade
    if params[:submission_id].present?
      @submission_grade = SubmissionGrade.find(params[:submission_id])
      authorized_permission!
      prev_submission = SubmissionGrade.where(:student_id => @submission_grade.student_id, :assignment_id => @submission_grade.assignment_id, :attempt_count => @submission_grade.attempt_count - 1).first
      unless prev_submission.nil?
        @prev_graded_rubric = prev_submission.graded_rubric
      else
        @prev_graded_rubric = GradedRubric.new(:rubric_id => @submission_grade.assignment.rubric.id)
      end
      @rubric_template = @submission_grade.assignment.rubric
    else
      flash[:notice] = "Submission does not existed!"
      redirect_to root_path
    end
  end

  def update_grade
    @submission_grade = SubmissionGrade.find(params[:submission_id])
    authorized_permission!
    @submission_grade.point = params[:submission_grade][:point]
    if @submission_grade.point < 8
      @submission_grade.submission_status = Constants::SUBMISSION_GRADE_STATUS_NOTPASSED
    else
      @submission_grade.submission_status = Constants::SUBMISSION_GRADE_STATUS_PASSED
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

  # def assign_mentor
  #   @ids = params[:submission_grades][ids]
  #   begin
  #     SubmissionGrade.where("id IN ? ", @ids).update_all(mentor_id: params[:mentor_id])
  #   rescue
  #     flash[:notice] = 'Assign error!!!'
  #   end
  # end

  # GET /submission_grades/1
  # GET /submission_grades/1.json
  def show;
  end

  # GET /submission_grades/new
  def new
    @submission_grade = SubmissionGrade.new
    init_submission_grade
    if params[:assignment].present?
      @submission_grade.assignment = Assignment.find(params[:assignment])
    end
  end

  # GET /submission_grades/1/edit
  def edit;
  end

  # POST /submission_grades
  # POST /submission_grades.json
  def create
    @submission_grade = SubmissionGrade.new(submission_grade_params)
    if student_can_submit?(@submission_grade.assignment_id, current_user.id)
      @submission_grade.attempt_count = find_attempt_count(@submission_grade.assignment_id, current_user.id)
      respond_to do |format|
        if @submission_grade.save
          unless @submission_grade.attempt_count == 1
            update_latest
          end
          format.html {redirect_to @submission_grade, notice: 'Submission grade was successfully created.'}
          format.json {render :show, status: :created, location: @submission_grade}
        else
          format.html {render :new}
          format.json {render json: @submission_grade.errors, status: :unprocessable_entity}
        end
      end
    else
      render js: "alert('You do not have permission to perform this action');"
      # flash.now[:notice] = 'You do not have permission to perform this action'
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
  def submission_grade_params
    # params.require(:submission_grade).permit(:assignment_id, :student_id, :submission_status, :attempt_count, :latest, :mentor_id, :grade_status, :graded_rubric_id, :point)
    params.require(:submission_grade).permit(:assignment_id, :student_id, :submission_status, :submission_file, :attempt_count, :latest, :mentor_id, :graded_rubric_id, :graded_file, :point)
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
    @submission_grade.submission_status = Constants::SUBMISSION_GRADE_STATUS_SUBMITTED
    @submission_grade.student_id = current_user.id
    @submission_grade.latest = true
    @submission_grade.mentor_id = nil
    # @submission_grade.rubric_id = nil
    @submission_grade.point = 0
  end

  def update_latest
    begin
      prev_latest = SubmissionGrade.where(student_id: @submission_grade.student_id, assignment_id: @submission_grade.assignment_id, latest: true).first
    rescue
      prev_latest = nil
    end
    unless prev_latest.nil?
      prev_latest.latest = false
      if prev_latest.save

      else
        flash[:notice] = 'Error when submit new solution: can not update recent submission'
        redirect_to :back
      end
    end
  end

  def authorized_granted!
    unless current_user.mentor? || current_user.admin?
      flash[:notice] = 'You do not have permission to take this action'
      redirect_to root_path
    end
  end

  # def update_grade_params
  #   params.require(:submission_grade).permit(:point)
  # end
  # def change_submission_status
  #   before_save_submission = SubmissionGrade.where(student_id: @submission_grade.student_id, assignment_id: @submission_grade.assignment_id, latest: true)
  #
  #   # if assigned new mentor
  #   if before_save_submission.status == SUBMISSION_GRADE_STATUS_SUBMITTED && before_save_submission.mentor.nil? && @submission_grade.mentor_id.present?
  #     @submission_grade.submission_status = SUBMISSION_GRADE_STATUS_ASSIGNED
  #   end
  # end
end
