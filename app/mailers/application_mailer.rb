# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  layout 'mailer'

  def default_url_options
    if Rails.env.production?
      {host: 'assignment.funix.edu.vn'}
    else
      {host: 'localhost:3000'}
    end
  end
end