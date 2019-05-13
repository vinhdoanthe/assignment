ActiveAdmin.register User do
  active_admin_import validate: true,
                      template_object: ActiveAdminImport::Model.new(
                          force_encoding: :auto
                      )
                      # before_batch_import: proc { |import|
                      #   import.file #current file used
                      #   import.resource #ActiveRecord class to import to
                      #   import.options # options
                      #   import.result # result before bulk iteration
                      #   import.headers # CSV headers
                      #   import.csv_lines #lines to import
                      #   import.model #template_object instance
                      # },
                      # after_batch_import: proc{ |import|
                      #   #the same
                      # }

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
