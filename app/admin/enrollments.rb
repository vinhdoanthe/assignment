ActiveAdmin.register Enrollment do
  active_admin_import validate: true,
                      template_object: ActiveAdminImport::Model.new(
                        force_encoding: :auto
                      )

  controller do
    belongs_to :users, :course_instances, optional: true
  end

  permit_params :user_id, :course_instance_id, :status, :start_date, :end_date
end
