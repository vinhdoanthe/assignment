class SubmissionGradesService
  
  def list_submissions params, user
    submissions = SubmissionGrade.all
    
    if params[:status].present?
      submissions = submissions.where(status: params[:status].to_s)
    end
    
    if user.mentor?
    submissions = submissions.where(mentor_id: user.id)
    end

    submissions.page(params[:page])
  end

end
