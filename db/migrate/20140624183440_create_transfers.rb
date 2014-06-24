class CreateTransfers < ActiveRecord::Migration
  def change
    create_table :transfers do |t|
      t.primary_key :id
      t.references :product
      t.references :from_location
      t.references :to_location
      t.integer :quantity
      t.references :transfer_staff
      t.text :note
      t.timestamps
    end
  end
end
