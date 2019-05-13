module GradedRubricsHelper
  def pre_calculate_point(graded_rubric)
    point = 0

    graded_rubric.graded_criteriums.each do |criterium|
      if criterium.criteria_type == Constants::CRITERIA_TYPE_PASS_FAIL
        if criterium.status == Constants::GRADED_CRITERIA_STATUS_PASSED
          if graded_rubric.submission_grade.attempt == 1
            point += (Settings.criteria_pass_fail_point_default * criterium.weight) / graded_rubric.submission_grade.assignment.rubric.total_weight
          else
            point += (Settings.criteria_pass_fail_point_default * criterium.weight / 2) / graded_rubric.submission_grade.assignment.rubric.total_weight
          end
        end
      elsif criterium.criteria_type == Constants::CRITERIA_TYPE_POINT
        if graded_rubric.submission_grade.attempt == 1
          point += ((criterium.point / Settings.criteria_point_max_point_default) * criterium.weight) / graded_rubric.submission_grade.assignment.rubric.total_weight
        else
          point += ((criterium.point / Settings.criteria_point_max_point_default) * criterium.weight / 2) / graded_rubric.submission_grade.assignment.rubric.total_weight
        end
      end
    end

    point *= Settings.submission_point_factor
    point
  end
end
