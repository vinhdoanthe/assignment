# frozen_string_literal: true

class GradedRubricsController < ApplicationController
  before_action :set_graded_rubric, only: %i[show edit update grade destroy]

  # GET /graded_rubrics
  # GET /graded_rubrics.json
  def index
    @graded_rubrics = GradedRubric.all
  end

  # GET /graded_rubrics/1
  # GET /graded_rubrics/1.json
  def show;
  end

  # GET /graded_rubrics/new
  def new
    @graded_rubric = GradedRubric.new
  end

  # GET /graded_rubrics/1/edit
  def edit;
  end

  # POST /graded_rubrics
  # POST /graded_rubrics.json
  def create
    @graded_rubric = GradedRubric.new(graded_rubric_params)

    respond_to do |format|
      if @graded_rubric.save
        format.html {redirect_to @graded_rubric, notice: 'Graded rubric was successfully created.'}
        format.json {render :show, status: :created, location: @graded_rubric}
      else
        format.html {render :new}
        format.json {render json: @graded_rubric.errors, status: :unprocessable_entity}
      end
    end
  end

  def grade
    respond_to do |format|
      if @graded_rubric.update(graded_rubric_params)
        format.html {redirect_to @graded_rubric, notice: 'Graded rubric was successfully updated.'}
        format.json {render :show, status: :ok, location: @graded_rubric}
      else
        format.html {render :edit}
        format.json {render json: @graded_rubric.errors, status: :unprocessable_entity}
      end
    end
  end

  def update
    @graded_rubric.update_attributes(graded_rubric_params)
    @graded_rubric.calculate_point!
    submission_grade = @graded_rubric.submission_grade
    if @graded_rubric.get_status == Constants::GRADED_RUBRIC_STATUS_FAILED
      submission_grade.status = Constants::SUBMISSION_GRADE_STATUS_NOTPASSED
    else
      submission_grade.status = Constants::SUBMISSION_GRADE_STATUS_PASSED
    end
    submission_grade.update_point(@graded_rubric.point)

    respond_to do |format|
      if @graded_rubric.save
        if submission_grade.save
          format.html {redirect_to @graded_rubric, notice: 'Graded rubric was successfully updated.'}
          format.json {render :show, status: :ok, location: @graded_rubric}
        else
          format.html {render :edit}
          format.json {render json: @graded_rubric.errors, status: :unprocessable_entity}
        end
      else
        format.html {render :edit}
        format.json {render json: @graded_rubric.errors, status: :unprocessable_entity}
      end
    end
  end

  # DELETE /graded_rubrics/1
  # DELETE /graded_rubrics/1.json
  def destroy
    @graded_rubric.destroy
    respond_to do |format|
      format.html {redirect_to graded_rubrics_url, notice: 'Graded rubric was successfully destroyed.'}
      format.json {head :no_content}
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_graded_rubric
    @graded_rubric = GradedRubric.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def graded_rubric_params
    params.require(:graded_rubric).permit(:comment,
                                          graded_criteriums_attributes:
                                              %i[id status comment point])
  end
end
