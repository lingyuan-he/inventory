class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.references :purchase  
      t.references :product
      t.integer :quantity
      t.timestamps
    end
  end
end
