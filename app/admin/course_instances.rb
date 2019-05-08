ActiveAdmin.register CourseInstance do

  controller do
    belongs_to :program, :course, optional: true
  end

  sidebar 'List assignments', only: %i[show edit] do
    li link_to 'Go to assignments', admin_course_instance_assignments_path(resource)
  end

  permit_params :program_id, :course_id, :code, :name, :description, :status

end
