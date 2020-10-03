class SubmissionGradesService
  
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
