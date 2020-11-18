class GradedRubricService

  def new_grade params
    # if params[:assignment_id].present? && params[:student_id].present? && params[:submission_grade_id]
    #   # Tìm các tiêu chí đã pass
    #   graded_criteria_list = GradedCriterium.find_by_sql(["SELECT * from graded_criteria
    #     INNER JOIN graded_rubrics ON graded_criteria.graded_rubric_id = graded_rubrics.id
    #     INNER JOIN submission_grades ON graded_rubrics.submission_grade_id = submission_grades.id
    #     WHERE graded_rubrics.deleted_at IS NULL AND submission_grades.assignment_id = ? AND submission_grades.student_id = ? AND submission_grades.deleted_at IS NULL", params[:assignment_id], params[:student_id]])
    #   # Tìm các tiêu chí được phép chấm lại
    # else
    #   return {
    #     success: false,
    #     data: nil
    #   }
    # end
  end

  # params:
  # submission_grade_id
  # graded_criteriums_attributes
  def pre_caculate params
    # find submission_grade
    s = SubmissionGrade.where(id: params[:submission_grade_id]).last
    return false if s.nil?

    # caculate point and state
    point = 0.0
    params[:graded_criteriums_attributes].each do |gc|
      if gc.pass_fail_type?
        if gc.passed?
          point += (Settings[:criteria][:pass_fail_point]) * gc.weight
        end
      elsif gc.point_type?
      end 
    end

    point
  end

  def build_graded_rubric submission_id, point, comment, graded_cr_list
    graded_rubric = GradedRubric.new
    graded_rubric.submission_grade_id = submission_id
    graded_rubric.point = point.round(2)
    graded_rubric.comment = comment

    ActiveRecord::Base.transaction do
      if graded_rubric.save
        graded_cr_list.each do |cr|
          graded_cr = GradedCriterium.new
          graded_cr.index = cr[:index]
          graded_cr.criteria_type = cr[:criteria_type]
          graded_cr.weight = cr[:weight]
          graded_cr.mandatory = cr[:mandatory]
          graded_cr.criteria_description = cr[:desc]
          graded_cr.meet_the_specification = cr[:spec]
          graded_cr.graded_rubric_id = graded_rubric.id
          graded_cr.comment = cr[:note]
          graded_cr.point = cr[:pointp]
          graded_cr.status = cr[:pointfp]
          graded_cr.save
        end
      end
    end

    graded_rubric.id
  end
end
