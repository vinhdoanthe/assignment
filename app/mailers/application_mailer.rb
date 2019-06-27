# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  layout 'mailer'

  def default_url_options
    {host: ENV['default_url']}
  end
end