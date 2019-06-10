class EnrollmentsController < ApplicationController

  before_action :authorized_admin

  def import_enrollments
    if params[:file].present?
      list_errors = Enrollment.import_from_file(params[:file])
      if list_errors.empty?
        flash[:success] = 'Import success!'
        redirect_to admin_enrollments_path
      else
        flash.now[:danger] = 'WARNING: Some errors have been occurred! Please see downloaded list'
        send_data list_errors, disposition: 'attachment', filename: 'errors.txt'
      end
    end
  end

  private

  def authorized_admin
    authenticate_user!
    require_admin!
  end

end