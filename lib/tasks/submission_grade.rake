# frozen_string_literal: true

namespace :submission_grade do
  desc 'submission_grade'
  task taken_back: :environment do
    puts 'Start sending cron email'
    SubmissionGradeMailer.submitted_email(User.first, SubmissionGrade.first).deliver_later
    puts 'Send email completed'
  end

end
