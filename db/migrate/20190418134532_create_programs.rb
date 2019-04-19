class CreatePrograms < ActiveRecord::Migration[5.2]
  def change
    create_table :programs do |t|
      t.string :code
      t.string :name
      t.string :status

      t.timestamps
    end
  end
end
