class ApplicationController < ActionController::Base
  helper ApplicationHelper

  protect_from_forgery with: :exception

  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_paper_trail_whodunnit

  def authenticate_active_admin_user!
    authenticate_user!
    unless current_user.admin?
      flash[:danger] = "Unauthorized Access!"
      redirect_to root_path
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) {|u| u.permit(:name, :email, :password)}

    devise_parameter_sanitizer.permit(:account_update) {|u| u.permit(:full_name, :role, :status, :funid, :email, :password, :current_password)}
  end

  def require_admin!
    unless current_user.admin?
      flash[:danger] = "You do not have permission to take this action"
      redirect_to root_path
    end
  end

end
