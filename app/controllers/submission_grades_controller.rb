class SubmissionGradesController < ApplicationController
  before_action :set_submission_grade, only: [:show, :edit, :update, :destroy]
  after_action :attach_file, only: [:update, :edit]
  before_action :purge_file, only: [:destroy]

  # GET /submission_grades
  # GET /submission_grades.json
  def index
    @submission_grades = SubmissionGrade.all
  end

  # GET /submission_grades/1
  # GET /submission_grades/1.json
  def show
  end

  # GET /submission_grades/new
  def new
    @submission_grade = SubmissionGrade.new
  end

  # GET /submission_grades/1/edit
  def edit
  end

  # POST /submission_grades
  # POST /submission_grades.json
  def create
    @submission_grade = SubmissionGrade.new(submission_grade_params)

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
    params.require(:submission_grade).permit(:assignment_id, :student_id, :submission_status, :submission_file, :attempt_count, :latest, :mentor_id, :grade_status, :graded_rubric_id, :graded_file, :point)
  end

  def attach_file
    @submission_grade.submission_file.attach(params[:submission_file])
    @submission_grade.graded_file.attach(params[:graded_file])
  end

  def purge_file
    @submission_grade.purge
  end
end
