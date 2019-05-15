# Preview all emails at http://localhost:3000/rails/mailers/submission_grade_mailer
class SubmissionGradeMailerPreview < ActionMailer::Preview
  def submitted_email_preview
    SubmissionGradeMailer.submitted_email(User.first, SubmissionGrade.first)
  end
end
