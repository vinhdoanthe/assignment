class HomeController < ApplicationController
  def index
    if current_user.admin?
      redirect_to admin_root_path
    elsif current_user.hannah?
      redirect_to admin_root_path
    elsif current_user.mentor?
      redirect_to assigned_submissions_path
    elsif current_user.learner?
      redirect_to active_assignments_path
    end
  end
end