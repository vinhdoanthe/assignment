class GradedRubricService
  
  def new_grade params
    if params[:assignment_id].present? && params[:student_id].present? && params[:submission_grade_id]
      # Tìm các tiêu chí đã pass
      graded_criteria_list = GradedCriterium.find_by_sql(["SELECT * from graded_criteria
        INNER JOIN graded_rubrics ON graded_criteria.graded_rubric_id = graded_rubrics.id
        INNER JOIN submission_grades ON graded_rubrics.submission_grade_id = submission_grades.id
        WHERE graded_rubrics.deleted_at IS NULL AND submission_grades.assignment_id = ? AND submission_grades.student_id = ? AND submission_grades.deleted_at IS NULL", params[:assignment_id], params[:student_id]])
      # Tìm các tiêu chí được phép chấm lại
    else
      return {
        success: false,
        data: nil
      }
    end
  end
end
