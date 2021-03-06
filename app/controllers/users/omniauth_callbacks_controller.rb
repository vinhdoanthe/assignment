# frozen_string_literal: true

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  skip_before_action :verify_authenticity_token

  def google_oauth2
    @user = User.from_omniauth(request.env['omniauth.auth'])
    if @user.nil?
      flash[:danger] = I18n.t('user.notexisted')
      redirect_to new_user_session_path
    elsif @user.persisted?
      flash[:success] = I18n.t 'devise.omniauth_callbacks.success', kind: 'Google'
      sign_in_and_redirect @user, event: :authentication
    end
  end

  def azureactivedirectory
    @user = User.from_omniauth(request.env['omniauth.auth'])
    if @user.nil?
      flash[:danger] = I18n.t('user.notexisted')
      redirect_to new_user_session_path
    elsif @user.persisted?
      flash[:success] = I18n.t 'devise.omniauth_callbacks.success', kind: 'Microsoft Azure'
      sign_in_and_redirect @user, event: :authentication
    end
  end
end
