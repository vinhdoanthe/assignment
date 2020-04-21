ActiveAdmin.register CourseInstance do

  filter :program, as: :searchable_select
  filter :course, as: :searchable_select
  filter :partner, as: :searchable_select
  filter :code
  filter :name
  filter :status, as: :searchable_select
  filter :locale, as: :searchable_select
  filter :created_at
  filter :updated_at

  index do
    selectable_column
    id_column
    column :code
    column :name
    column :program
    column :course
    column :status
    column :locale
    column :partner
    column :created_at
    column :updated_at
  end

  controller do
    belongs_to :program, :course, :partner, optional: true
  end

  sidebar 'List assignments', only: %i[show edit] do
    li link_to 'Go to assignments', admin_course_instance_assignments_path(resource)
  end

  permit_params :program_id, :course_id, :partner_id, :code, :name, :description, :status

end
