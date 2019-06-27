class AddLocaleToInstance < ActiveRecord::Migration[5.2]
  def change
    add_column :course_instances, :locale, :string, null: false, default: :vi
    add_column :partners, :is_send_email, :boolean, null: false, default: false
  end
end
