class CreateRestocks < ActiveRecord::Migration
  def change
    create_table :restocks do |t|
      t.primary_key :id
      t.references :product
      t.references :location
      t.integer :quantity
      t.decimal :unit_cost
      t.references :restock_staff
      t.text :note
      t.timestamps
    end
  end
end
