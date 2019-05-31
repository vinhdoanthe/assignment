class AddPartner < ActiveRecord::Migration[5.2]
  def change
    create_table :partners do |t|
      t.string :org, null: false, unique: true
      t.string :email, null: false, unique: true
      t.timestamps
    end

    add_reference :course_instances, :partner
  end
end
