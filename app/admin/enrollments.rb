ActiveAdmin.register Enrollment do

  config.per_page = [100, 50, 25]
  filter :user, as: :searchable_select
  filter :course_instance, as: :searchable_select
  filter :status, as: :select
  filter :created_at
  filter :updated_at

  controller do
    belongs_to :users, :course_instances, optional: true
  end

  collection_action :import_enrollments do

  end

  collection_action :reset_results do

  end

  action_item only: :index do
    if current_user.admin?
      link_to('Reset Old Results', reset_results_admin_enrollments_path)
    end
  end

  action_item only: :index do
    if current_user.admin?
      link_to('Import Enrollments', import_enrollments_admin_enrollments_path)
    end
  end

  permit_params :user_id, :course_instance_id, :status, :start_date, :end_date
end
