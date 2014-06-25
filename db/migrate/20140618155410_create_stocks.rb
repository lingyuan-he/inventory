class CreateStocks < ActiveRecord::Migration
  def change
    create_table :stocks do |t|
      t.primary_key :id
      t.references :product
      t.references :location
      t.integer :quantity_left
      t.integer :alarm_threshold
      t.boolean :active
      t.timestamps
    end
  end
end
