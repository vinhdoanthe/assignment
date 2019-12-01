# frozen_string_literal: true

class GradedRubricsController < ApplicationController
  before_action :set_graded_rubric, only: %i[show]

  def new
    if params[:assignment_id].present? && params[:student_id].present? && params[:submission_grade_id]
      assignment_id = params[:assignment_id]
      student_id = params[:student_id]
      submission_grade_id = params[:submission_grade_id]
      submission_grades = SubmissionGrade.select(['id']).where(assignment_id: assignment_id,
                                                               student_id: student_id)
      graded_rubric = GradedRubric.select(['id']).where(submission_grade_id: submission_grades)
      graded_criteriums = GradedCriterium.where(graded_rubric_id: graded_rubric)
      @can_not_be_regrade_criteriums = graded_criteriums.reject(&:can_be_regrade?)
      can_not_be_regrade_index = @can_not_be_regrade_criteriums.map {|criterium| criterium.index}
      rubrics = Rubric.select(['id']).where(assignment_id: assignment_id)
      criteria_formats = CriteriaFormat.where(rubric_id: rubrics)
      @to_be_grade_criteria_formats = criteria_formats.reject {|criteria| can_not_be_regrade_index.include?(criteria.index)}

      @graded_rubric = GradedRubric.new(submission_grade_id: submission_grade_id)
      # Build graded_criteriums
      @to_be_grade_criteria_formats.each do |criteria|
        @graded_rubric.graded_criteriums.build(index: criteria.index,
                                               criteria_description: criteria.criteria_description,
                                               outcome: criteria.outcome,
                                               meet_the_specification: criteria.meet_the_specification,
                                               mandatory: criteria.mandatory,
                                               criteria_type: criteria.criteria_type,
                                               weight: criteria.weight)
      end
    else
      redirect_to root_path
    end
  end

  def preview_get
    redirect_to root_path
  end

  def preview
    @graded_rubric = GradedRubric.new(graded_rubric_params)
    render :preview
  end

  def show;
  end

  def grade
    @graded_rubric = GradedRubric.new(graded_rubric_params)
    @graded_rubric.calculate_point!
    logger = Rails.logger
    logger.info '@graded_rubric.point'
    logger.info @graded_rubric.point
    submission_grade = @graded_rubric.submission_grade
    if @graded_rubric.status == Constants::GRADED_RUBRIC_STATUS_FAILED
      submission_grade.status = Constants::SUBMISSION_GRADE_STATUS_NOT_PASSED
    else
      submission_grade.status = Constants::SUBMISSION_GRADE_STATUS_PASSED
    end
    submission_grade.update_point(@graded_rubric.point)
    submission_grade.graded_at = Time.now

    if @graded_rubric.save
      if submission_grade.save
        SubmissionGradeMailer.graded_email(submission_grade.id).deliver_later
        redirect_to @graded_rubric.submission_grade,
                    success: 'Graded successfully!'

      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_graded_rubric
    @graded_rubric = GradedRubric.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def graded_rubric_params
    params.require(:graded_rubric).permit(:submission_grade_id,
                                          :comment,
                                          graded_criteriums_attributes:
                                              %i[id index weight mandatory
                                                 criteria_description outcome meet_the_specification
                                                 criteria_type status point comment])
  end
end
