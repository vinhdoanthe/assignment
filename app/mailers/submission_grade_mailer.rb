class SubmissionGradeMailer < ApplicationMailer
  default from: 'noreply-assignment@funix.edu.vn'

  def submitted_email(user, submission_grade)
    @user = User.find(user.id)
    @submission_grade = SubmissionGrade.find(submission_grade.id)
    mail(to: "#{@user.email}, #{Constants::KHAO_THI_EMAIL}",
         subject: "Assignment submitted #{@submission_grade.display_name}")
  end

  def assigned_mentor_email(mentor_id, submission_grade)
    @mentor = User.find(mentor_id)
    @submission_grade = SubmissionGrade.find(submission_grade.id)
    mail(to: "#{@mentor.email}, #{Constants::KHAO_THI_EMAIL}",
         subject: "You've been assigned to grade #{@submission_grade.display_name}")
  end

  def taken_back_email(mentor_id, submission_grade)
    @mentor = User.find(mentor_id)
    @submission_grade = SubmissionGrade.find(submission_grade.id)
    mail(to: "#{@mentor.email}, #{Constants::KHAO_THI_EMAIL}",
         subject: "#{@submission_grade.display_name} has been taken back")
  end

  def graded_email(grade_record_id)
    @grade_record = SubmissionGrade.find(grade_record_id)
    @mentor = User.find(@grade_record.mentor_id)
    @learner = User.find(@grade_record.student_id)
    mail(to: "#{@learner.email}, #{@mentor.email}, #{Constants::KHAO_THI_EMAIL}",
         subject: 'Assignment Grade Result')
  end
end
