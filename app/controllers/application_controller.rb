# frozen_string_literal: true

class ApplicationController < ActionController::Base
  helper ApplicationHelper

  protect_from_forgery with: :exception
  add_flash_types :success, :danger, :warning, :info

  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_paper_trail_whodunnit

  def authenticate_active_admin_user!
    authenticate_user!
    unless current_user.admin? || current_user.hannah?
      flash[:danger] = 'Unauthorized Access!'
      redirect_to root_path
    end
  end

  def access_denied(exception)
    redirect_to root_path, alert: exception.message
  end

  def set_locale
    locale = params[:locale].to_s.strip.to_sym
    I18n.locale = I18n.available_locales.include?(locale) ? locale : I18n.default_locale
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) {|u| u.permit(:name, :email, :password)}

    devise_parameter_sanitizer.permit(:account_update) {|u| u.permit(:full_name, :role, :status, :funid, :email, :password, :current_password)}
  end

  def require_admin!
    unless current_user.admin?
      flash[:danger] = 'You do not have permission to take this action'
      redirect_to root_path
    end
  end

  def user_for_paper_trail
    user_signed_in? ? current_user.try(:id) : 'Unknown user'
  end

end
