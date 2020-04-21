# frozen_string_literal: true

ActiveAdmin.register Assignment do
  
  filter :course_instance, as: :searchable_select
  filter :created_at
  filter :updated_at
  index do
    selectable_column
    id_column
    column :name
    column :course_instance
    column :max_attempt
    column :description
    column :created_at
    column :updated_at
  end

  controller do
    belongs_to :course_instance, optional: true
  end

  permit_params :course_instance_id, :name, :status, :max_attempt, :description, :submit_type, :grade_type

  sidebar 'Rubric', only: %i[show edit] do
    if resource.rubric.nil?
      li link_to 'Create rubric', new_admin_rubric_path
    else
      li link_to 'View rubric', admin_rubric_path(assignment.rubric)
    end
  end
end
