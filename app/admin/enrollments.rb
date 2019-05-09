ActiveAdmin.register Enrollment do

  controller do
    belongs_to :users, :course_instances, optional: true
  end

  permit_params :user_id, :course_instance_id, :status, :start_date, :end_date

end
