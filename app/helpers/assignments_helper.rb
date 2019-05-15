module AssignmentsHelper
  include Constants

  def validate_access_active_assignments?(student_id)
    begin
      target_user = User.find(student_id)
    rescue ActiveRecord::RecordNotFound => e
      target_user = nil
    end
    if target_user.nil?
      false
    else
      logged_user = User.find(current_user.id)
      # TODO Need to check role here
      !(target_user != logged_user)
    end
  end

  def get_submission(assignment_id)
    SubmissionGrade.where(:assignment_id => assignment_id, :student_id => current_user.id, :is_latest => true).first
  end
end