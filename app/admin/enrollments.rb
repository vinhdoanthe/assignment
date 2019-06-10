ActiveAdmin.register Enrollment do

  controller do
    belongs_to :users, :course_instances, optional: true
  end

  collection_action :import_enrollments do

  end


  action_item only: :index do
    link_to('Import Enrollments', import_enrollments_admin_enrollments_path)
  end

  permit_params :user_id, :course_instance_id, :status, :start_date, :end_date
end
