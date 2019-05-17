# frozen_string_literal: true

class GradedRubricsController < ApplicationController
  before_action :set_graded_rubric, only: %i[show grade load_rubric preview]

  def load_rubric
  end


  def preview_get
    redirect_to load_rubric_path
  end

  def preview
    @graded_rubric.assign_attributes(graded_rubric_params)
    render :preview
  end

  def show
  end

  def grade
    @graded_rubric.update_attributes(graded_rubric_params)
    @graded_rubric.calculate_point!
    submission_grade = @graded_rubric.submission_grade
    if @graded_rubric.get_status == Constants::GRADED_RUBRIC_STATUS_FAILED
      submission_grade.status = Constants::SUBMISSION_GRADE_STATUS_NOT_PASSED
    else
      submission_grade.status = Constants::SUBMISSION_GRADE_STATUS_PASSED
    end
    submission_grade.update_point(@graded_rubric.point)

    if @graded_rubric.save
      if submission_grade.save
        redirect_to @graded_rubric.submission_grade,
                    notice: 'Graded successfully!'
      else
        render :load_rubric
      end
    else
      render :load_rubric
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