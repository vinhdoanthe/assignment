# frozen_string_literal: true

ActiveAdmin.register Rubric do

  controller do
    belongs_to :assignment, optional: true
  end

  show do
    panel 'Assignment' do
      h2 rubric.display_name
    end
    panel 'Criteria' do
      table_for rubric.criteria_formats do
        column :index
        column :description
        column :criteria_type
        column :weight
        column :is_required
        column :point
      end
    end
  end

  form do |form|
    form.semantic_errors
    form.inputs 'Assignment' do
      form.input :assignment
    end

    form.inputs 'Criteria' do
      form.has_many :criteria_formats,
                    new_record: 'Add criteria',
                    allow_destroy: true do |criteria_form|
        criteria_form.semantic_errors

        criteria_form.inputs do
          criteria_form.input :index
          criteria_form.input :description
          criteria_form.input :criteria_type
          # if criteria_form.object.criteria_type
          # criteria_form.input :point
          # else
          # Do nothing
          criteria_form.input :point
          # end
          criteria_form.input :weight
          criteria_form.input :is_required
        end
      end
    end
    form.actions
  end

  permit_params :assignment_id,
                criteria_formats_attributes: [:id, :index, :description, :criteria_type, :is_required, :weight, :point, :_destroy]
end
