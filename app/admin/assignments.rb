ActiveAdmin.register Assignment do
  controller do
    belongs_to :course_instance, optional: true
  end

  permit_params :course_instance_id, :name, :status, :max_attempt, :description, :grade_type

  sidebar 'Rubric', only: %i[show edit] do
    if resource.rubric.nil?
      li link_to "Create rubric", new_admin_rubric_path
    else
      li link_to 'View rubric', assignment.rubric
    end
  end
end
