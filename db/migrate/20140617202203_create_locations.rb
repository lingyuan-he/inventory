class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.primary_key :id
      t.string :name
      t.string :address
      t.references :manager
      t.text :note
      t.timestamps
    end
  end
end
