# frozen_string_literal: true

module GradedRubricsHelper
  def pre_calculate_point(graded_rubric)
    point = 0.to_f

    graded_rubric.graded_criteriums.each do |criterium|
      if criterium.criteria_type == Constants::CRITERIA_TYPE_PASS_FAIL
        if criterium.status == Constants::GRADED_CRITERIA_STATUS_PASSED
          point += (Settings[:criteria][:pass_fail_point] * criterium.weight).to_f / (graded_rubric.submission_grade.assignment.rubric.total_weight).to_f
        end
      elsif criterium.criteria_type == Constants::CRITERIA_TYPE_POINT
        point += ((criterium.point.to_f / (Settings[:criteria][:point_max_point]).to_f) * criterium.weight).to_f / (graded_rubric.submission_grade.assignment.rubric.total_weight).to_f
      end
    end

    point *= Settings[:submission][:point_factor]

    if graded_rubric.submission_grade.attempt != 1
      point /= (2**(graded_rubric.submission_grade.attempt-1))
      prev_attempt = SubmissionGrade.where(assignment_id: graded_rubric.submission_grade.assignment_id,
                                           student_id: graded_rubric.submission_grade.student_id,
                                           attempt: graded_rubric.submission_grade.attempt - 1).first
      point += prev_attempt.point
    end
    point.round(2)
  end

  def pre_calculate_status(graded_rubric)
    temp_status = Constants::SUBMISSION_GRADE_STATUS_PASSED
    graded_rubric.graded_criteriums.each do |criterium|
      next unless criterium.mandatory
      if criterium.criteria_type == Constants::CRITERIA_TYPE_PASS_FAIL
        if criterium.status == Constants::GRADED_CRITERIA_STATUS_FAILED
          temp_status = Constants::SUBMISSION_GRADE_STATUS_NOT_PASSED
        end
      else #Constants::CRITERIA_TYPE_POINT
        if criterium.point.zero?
          temp_status = Constants::SUBMISSION_GRADE_STATUS_NOT_PASSED
        end
      end
    end
    temp_status
  end
end
