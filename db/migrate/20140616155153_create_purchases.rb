class CreatePurchases < ActiveRecord::Migration
  def change
    create_table :purchases do |t|
      t.primary_key :id
      t.string :invoice_number
      t.string :vending_machine
      t.decimal :total_amount
      t.timestamps
    end
  end
end
