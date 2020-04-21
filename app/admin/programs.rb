ActiveAdmin.register Program do
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
end
