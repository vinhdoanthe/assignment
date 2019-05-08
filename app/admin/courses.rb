ActiveAdmin.register Course do

  permit_params :code, :name, :status

  sidebar 'References', only: %i[show edit] do
    li link_to 'Go to instances', admin_course_course_instances_path(resource)
  end

end
