class CreateVendingMachines < ActiveRecord::Migration
  def change
    create_table :vending_machines do |t|
      t.primary_key :id
      t.string :name
      t.string :address
      t.references :stock_location
      t.text :note
      t.timestamps
    end
  end
end
