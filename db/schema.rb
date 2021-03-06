# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20140624183440) do

  create_table "employees", :force => true do |t|
    t.string   "name"
    t.string   "role"
    t.string   "phone"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "items", :force => true do |t|
    t.integer  "purchase_id"
    t.integer  "product_id"
    t.integer  "quantity"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "locations", :force => true do |t|
    t.string   "name"
    t.string   "address"
    t.integer  "manager_id"
    t.text     "note"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "manufacturers", :force => true do |t|
    t.string   "name"
    t.string   "address"
    t.string   "contact_name"
    t.string   "contact_phone"
    t.string   "contact_email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "products", :force => true do |t|
    t.string   "name"
    t.integer  "manufacturer_id"
    t.text     "description"
    t.decimal  "unit_price"
    t.integer  "quantity_sold"
    t.integer  "quantity_left"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "purchases", :force => true do |t|
    t.string   "invoice_number"
    t.integer  "vending_machine_id"
    t.decimal  "total_amount"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "restocks", :force => true do |t|
    t.integer  "product_id"
    t.integer  "location_id"
    t.integer  "quantity"
    t.decimal  "unit_cost"
    t.integer  "restock_staff_id"
    t.text     "note"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "stocks", :force => true do |t|
    t.integer  "product_id"
    t.integer  "location_id"
    t.integer  "quantity_left"
    t.integer  "alarm_threshold"
    t.boolean  "active"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "transfers", :force => true do |t|
    t.integer  "product_id"
    t.integer  "from_location_id"
    t.integer  "to_location_id"
    t.integer  "quantity"
    t.integer  "transfer_staff_id"
    t.text     "note"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "vending_machines", :force => true do |t|
    t.string   "name"
    t.string   "address"
    t.integer  "stock_location_id"
    t.text     "note"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
