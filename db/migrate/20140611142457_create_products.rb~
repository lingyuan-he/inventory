class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.primary_key :id
      t.string :name
      t.references :manufacturer
      t.text :description
      t.integer :quantity_sold
      t.integer :quantity_left
      t.boolean :archieved
      t.timestamps
    end
  end
end
