class SubmissionGradeMailer < ApplicationMailer
  default from: ENV['default_email_from']

  def submitted_email(user, submission_grade)
    @user = User.find(user.id)
    @submission_grade = SubmissionGrade.find(submission_grade.id)
    I18n.with_locale(submission_grade.assignment.course_instance.locale) do
      mail(to: "#{@user.email}, #{Constants::KHAO_THI_EMAIL}",
           subject: I18n.t('mailer.submission_grade.submitted_email.subject', submission_name: @submission_grade.display_name))
    end
  end

  def assigned_mentor_email(mentor_id, submission_grade)
    @mentor = User.find(mentor_id)
    @submission_grade = SubmissionGrade.find(submission_grade.id)
    I18n.with_locale(submission_grade.assignment.course_instance.locale) do
      mail(to: "#{@mentor.email}, #{Constants::KHAO_THI_EMAIL}",
           subject: I18n.t('mailer.submission_grade.assigned_mentor.subject', submission_name: @submission_grade.display_name))
    end
  end

  def taken_back_email(mentor_id, submission_grade)
    @mentor = User.find(mentor_id)
    @submission_grade = SubmissionGrade.find(submission_grade.id)
    I18n.with_locale(submission_grade.assignment.course_instance.locale) do
      mail(to: "#{@mentor.email}, #{Constants::KHAO_THI_EMAIL}",
           subject: t('mailer.submission_grade.taken_back_email.subject', submission_name: @submission_grade.display_name))
    end
  end

  def graded_email(grade_record_id)
    @grade_record = SubmissionGrade.find(grade_record_id)
    @mentor = User.find(@grade_record.mentor_id)
    @learner = User.find(@grade_record.student_id)
    @partner = Partner.find(@grade_record.assignment.course_instance.partner_id)
    to_list = "#{@learner.email}, #{@mentor.email}, #{Constants::KHAO_THI_EMAIL}"
    if @partner.is_send_email
      to_list = "#{to_list}, #{@partner.email}"
    end
    I18n.with_locale(@grade_record.assignment.course_instance.locale) do
      mail(to: to_list,
           subject: t('mailer.submission_grade.graded_email.subject',
                      grade_record_name: @grade_record.display_name,
                      learner_email: @learner.email,
                      mentor_email: @mentor.email))
    end
  end
end