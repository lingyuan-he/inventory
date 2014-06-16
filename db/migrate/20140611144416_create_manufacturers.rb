class CreateManufacturers < ActiveRecord::Migration
  def change
    create_table :manufacturers do |t|
      t.primary_key :id
      t.string :name
      t.string :address
      t.string :contact_name
      t.string :contact_phone
      t.string :contact_email
      t.timestamps
    end
  end
end
