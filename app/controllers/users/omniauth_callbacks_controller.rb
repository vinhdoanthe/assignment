# frozen_string_literal: true

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google_oauth2
    @user = User.from_omniauth(request.env['omniauth.auth'])
    if @user.persisted?
      flash[:success] = I18n.t 'devise.omniauth_callbacks.success', kind: 'Google'
      sign_in_and_redirect @user, event: :authentication
    else
      # session['devise.google_data'] = request.env['omniauth.auth']
      flash[:info] = 'Your email do not exist on system. Please use your FUNiX email to login'
      redirect_to new_session_path
    end
  end
end
