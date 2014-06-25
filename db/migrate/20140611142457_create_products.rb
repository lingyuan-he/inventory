class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.primary_key :id
      t.string :name
      t.references :manufacturer
      t.text :description
      t.decimal :unit_price
      t.integer :quantity_sold
      t.integer :quantity_left
      t.timestamps
    end
  end
end
