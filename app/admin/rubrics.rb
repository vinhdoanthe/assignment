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
        column :criteria_description
        column :outcome
        column :meet_the_specification
        column :criteria_type
        column :weight
        column :mandatory
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
          criteria_form.input :criteria_description
          criteria_form.input :outcome
          criteria_form.input :meet_the_specification
          criteria_form.input :criteria_type
          criteria_form.input :weight
          criteria_form.input :mandatory
        end
      end
    end
    form.actions
  end

  permit_params :assignment_id,
                criteria_formats_attributes: %i[id index criteria_description
                                                outcome meet_the_specification
                                                criteria_type mandatory weight _destroy]
end
