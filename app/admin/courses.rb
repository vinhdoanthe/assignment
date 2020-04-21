ActiveAdmin.register Course do

  filter :code
  filter :name
  filter :status, as: :searchable_select
  filter :created_at
  filter :updated_at

  index do
    selectable_column
    id_column
    column :code
    column :name
    column :status
    column :created_at
    column :updated_at
  end
  permit_params :code, :name, :status

  sidebar 'References', only: %i[show edit] do
    li link_to 'Go to instances', admin_course_course_instances_path(resource)
  end

end
