class CreateEmployees < ActiveRecord::Migration
  def change
    create_table :employees do |t|
      t.primary_key :id
      t.string :name
      t.string :role
      t.string :phone
      t.string :email
      t.timestamps
    end
  end
end
