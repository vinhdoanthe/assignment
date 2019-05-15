class SubmissionGradeMailer < ApplicationMailer
  default from: 'noreply-assignment@funix.edu.vn'

  def submitted_email(user, submission_grade)
    @user = User.find(user.id)
    @submission_grade = SubmissionGrade.find(submission_grade.id)
    mail(to: @user.email, subject: "Assignment submitted #{@submission_grade.display_name}")
  end

end
