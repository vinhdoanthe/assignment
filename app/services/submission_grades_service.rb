class SubmissionGradesService

  def caculate_point_and_state params
    binding.pry
    submission = SubmissionGrade.where(id: params[:submission][:submission_grade_id]).first
    return nil if submission.nil?

    params[:cr].each do |key, value|
      binding.pry
    end
  end

  def get_grade_form_params params 
    # # Tìm các tiêu chí đã chấm
    # if !assignment_id.nil? && !student_id.nil? && !submission_id.nil?
    #   # Tìm các tiêu chí đã pass
    #   graded_criteria_list = GradedCriterium.find_by_sql(["SELECT * from graded_criteria
    #     INNER JOIN graded_rubrics ON graded_criteria.graded_rubric_id = graded_rubrics.id
    #     INNER JOIN submission_grades ON graded_rubrics.submission_grade_id = submission_grades.id
    #     WHERE graded_rubrics.deleted_at IS NULL AND submission_grades.assignment_id = ? AND submission_grades.student_id = ? AND submission_grades.deleted_at IS NULL", assignment_id, student_id])

    #   passed_criteria = graded_criteria_list.reject(&:can_be_regrade?)
    #   passed_criteria_index = pass_criteria.map {|cr| rd.id}

    #   cr_formats = CriteriaFormat.find_by_sql(['criteria_formats LEFT JOIN rubrics ON criteria_formats.rubric_id = rubrics.id WHERE rubrics.assignment_id = ?', params[:assignment_id])
    #   not_passed_cr_formats = cr_formats.reject{|cr| passed_criteria_index.include?(cr.index)}
    # else
    #   return {
    #     success: false,
    #     data: nil
    #   }
    # end
    if params[:assignment_id].present? && params[:student_id].present? && params[:submission_grade_id]
      assignment_id = params[:assignment_id]
      student_id = params[:student_id]
      submission_grade_id = params[:submission_grade_id]
      submission_grades = SubmissionGrade.select(['id']).where(assignment_id: assignment_id,
                                                               student_id: student_id)
      graded_rubric = GradedRubric.select(['id']).where(submission_grade_id: submission_grades)
      graded_criteriums = GradedCriterium.where(graded_rubric_id: graded_rubric)
      can_not_be_regrade_criteriums = graded_criteriums.reject(&:can_be_regrade?)
      can_not_be_regrade_index = can_not_be_regrade_criteriums.map {|criterium| criterium.index}
      rubrics = Rubric.select(['id']).where(assignment_id: assignment_id)
      criteria_formats = CriteriaFormat.where(rubric_id: rubrics)
      to_be_grade_criteria_formats = criteria_formats.reject {|criteria| can_not_be_regrade_index.include?(criteria.index)}

      graded_rubric = GradedRubric.new(submission_grade_id: submission_grade_id)
      # Build graded_criteriums
      # to_be_grade_criteria_formats.each do |criteria|
      #   graded_rubric.graded_criteriums.build(index: criteria.index,
      #                                          criteria_description: criteria.criteria_description,
      #                                          outcome: criteria.outcome,
      #                                          meet_the_specification: criteria.meet_the_specification,
      #                                          mandatory: criteria.mandatory,
      #                                          criteria_type: criteria.criteria_type,
      #                                          weight: criteria.weight)
      # end
      submission = SubmissionGrade.where(id: submission_grade_id).first
      return submission, can_not_be_regrade_criteriums, to_be_grade_criteria_formats 
    else
      return nil, nil, nil 
    end
  end

  def list_submissions params, user
    submissions = SubmissionGrade.includes(:student, :assignment, assignment: :course_instance, submission_file_attachment: :blob)

    if params[:status].present?
      submissions = submissions.where(status: params[:status].to_s)
    end

    if user.mentor?
      submissions = submissions.where(mentor_id: user.id)
    end

    submissions.order(:created_at => :DESC).page(params[:page])
  end

  def status_report user
    SubmissionGrade.where(mentor_id: user.id).group(:status).count
  end
  

end
