class HomeController < ApplicationController
  def index
    if current_user.admin?
      redirect_to rails_admin_path + '/submission_grade'
    elsif current_user.mentor?
      redirect_to assigned_submissions_path
    elsif current_user.learner?
      redirect_to active_assignments_path
    end
  end
end