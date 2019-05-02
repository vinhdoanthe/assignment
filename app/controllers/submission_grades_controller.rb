class SubmissionGradesController < ApplicationController
  include Constants
  include SubmissionGradesHelper
  include SmartListing::Helper::ControllerExtensions
  helper  SmartListing::Helper
  before_action :set_submission_grade, only: [:show, :edit, :update, :destroy]
  before_action :authorized_admin!, only: [:edit, :update, :destroy, :index, :list_latest_submissions]
  before_action :authorized_owner!, only: [:show]
  after_action :attach_file, only: [:update, :update]
  before_action :purge_file, only: [:destroy]

  # GET /submission_grades
  # GET /submission_grades.json
  def index
    @submission_grades = SubmissionGrade.where(latest: true)
  end

  def list_latest_submissions
    @latest_submissions = smart_listing_create(:latest_submissions, SubmissionGrade.where(:latest => true), partial: 'submission_grades/latest_submissions')
  end

  # GET /submission_grades/1
  # GET /submission_grades/1.json
  def show
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
  def edit
  end

  # POST /submission_grades
  # POST /submission_grades.json
  def create
    @submission_grade = SubmissionGrade.new(submission_grade_params)
    if student_can_submit?(@submission_grade.assignment_id, current_user.id)
      @submission_grade.attempt_count = find_attempt_count(@submission_grade.assignment_id, current_user.id)
      respond_to do |format|
        if @submission_grade.save
          format.html {redirect_to @submission_grade, notice: 'Submission grade was successfully created.'}
          format.json {render :show, status: :created, location: @submission_grade}
        else
          format.html {render :new}
          format.json {render json: @submission_grade.errors, status: :unprocessable_entity}
        end
      end
    else
      render :js => "alert('You do not have permission to perform this action');"
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
    @submission_grade.submission_file.attach(params[:submission_file])
    @submission_grade.graded_file.attach(params[:graded_file])
  end

  def purge_file
    @submission_grade.submission_file.purge
    @submission_grade.graded_file.purge
  end

  def authorized_admin!
    if current_user.admin?

    else
      flash.now[:notice] = 'You do not have permission to perform this action'
      redirect_to root_path
    end
  end

  def authorized_owner!
    if current_user.submission_grades.include?(@submission_grade)

    else
      flash.now[:notice] = 'You do not have permission to perform this action'
      redirect_to root_path
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
end
