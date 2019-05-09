ActiveAdmin.register User do
  form do |form|
    title form.object.new_record? ? 'Add new user' : 'Edit user'
    form.semantic_errors
    inputs 'User information' do
      form.input :email
      form.input :password
      form.input :role
      form.input :status
      form.input :full_name
    end
    form.actions
  end

  index do
    id_column
    column :email
    column :full_name
    column :role
    column :status
    actions
  end

  permit_params :email, :password, :role, :status, :full_name
end
