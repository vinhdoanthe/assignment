class SubmissionGradesService

  def caculate_point_and_state params
    submission = SubmissionGrade.where(id: params[:submission][:submission_grade_id]).first
    return nil if submission.nil?

    attempt = submission.attempt

    total_weight = submission.assignment.rubric.total_weight.to_f

    point = 0.0

    cr_list = []
    cr = {}

    params[:cr].each do |key, value|
      cr = value
      cr[:index] = key
      cr_list.append cr

      if value[:criteria_type] == Constants::CRITERIA_TYPE_PASS_FAIL
        if value[:pointfp] == Constants::GRADED_CRITERIA_STATUS_PASSED
          point += (Settings[:criteria][:pass_fail_point] * value[:weight].to_f) / total_weight
        end
      elsif value[:criteria_type] == Constants::CRITERIA_TYPE_POINT
        point += ((value[:pointp].to_f)/(Settings[:criteria][:point_max_point].to_f) * value[:weight].to_f)/total_weight
      end
    end

    point *= Settings[:submission][:point_factor]

    if attempt != 1
      point /= (2 ** (attempt - 1))
      prev_submission = SubmissionGrade.where(assignment_id: submission.assignment_id, student_id: submission.student_id, attempt: (attempt-1)).first
      point += prev_submission.point
    end

    # caculate state
    status = Constants::SUBMISSION_GRADE_STATUS_PASSED
    params[:cr].each do |key, value|
      next unless value[:mandatory] == Constants::STR_TRUE

      if value[:criteria_type] == Constants::CRITERIA_TYPE_PASS_FAIL
        if value[:pointfp] == Constants::GRADED_CRITERIA_STATUS_FAILED
          status = Constants::SUBMISSION_GRADE_STATUS_NOT_PASSED
        end
      else
        if value[:pointp].to_i.zero?
          status = Constants::SUBMISSION_GRADE_STATUS_NOT_PASSED
        end
      end
    end

    # binding.pry
    {
      point: point.round(2), 
      status: status, 
      submission_id: submission.id,
      comment: params[:submission][:comment],
      cr_list: cr_list
    }
  end

  def grade params
    submission = SubmissionGrade.where(id: params[:submission_id]).first
    return nil if submission.nil?

    attempt = submission.attempt

    total_weight = submission.assignment.rubric.total_weight.to_f

    point = 0.0

    cr_list = []
    cr = {}

    params[:cr].each do |key, value|
      cr = value
      cr[:index] = key
      cr_list.append cr

      if value[:criteria_type] == Constants::CRITERIA_TYPE_PASS_FAIL
        if value[:pointfp] == Constants::GRADED_CRITERIA_STATUS_PASSED
          point += (Settings[:criteria][:pass_fail_point] * value[:weight].to_f) / total_weight
        end
      elsif value[:criteria_type] == Constants::CRITERIA_TYPE_POINT
        point += ((value[:pointp].to_f)/(Settings[:criteria][:point_max_point].to_f) * value[:weight].to_f)/total_weight
      end
    end

    point *= Settings[:submission][:point_factor]

    if attempt != 1
      point /= (2 ** (attempt - 1))
      prev_submission = SubmissionGrade.where(assignment_id: submission.assignment_id, student_id: submission.student_id, attempt: (attempt-1)).first
      point += prev_submission.point
    end

    # caculate state
    status = Constants::SUBMISSION_GRADE_STATUS_PASSED
    params[:cr].each do |key, value|
      next unless value[:mandatory] == Constants::STR_TRUE

      if value[:criteria_type] == Constants::CRITERIA_TYPE_PASS_FAIL
        if value[:pointfp] == Constants::GRADED_CRITERIA_STATUS_FAILED
          status = Constants::SUBMISSION_GRADE_STATUS_NOT_PASSED
        end
      else
        if value[:pointp].to_i.zero?
          status = Constants::SUBMISSION_GRADE_STATUS_NOT_PASSED
        end
      end
    end

    # build graded_rubrics 
    graded_rubric_id = GradedRubricService.new.build_graded_rubric params[:submission_id], point, params[:note], cr_list

    if !graded_rubric_id.nil?
      if submission.update(status: status, point: point)
        SubmissionGradeMailer.graded_email(submission.id).deliver_later
        return true
      end
    end

    return false
  end

  def get_grade_form_params params 
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
