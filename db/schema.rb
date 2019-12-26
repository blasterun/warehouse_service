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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_12_25_145000) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "clients", force: :cascade do |t|
    t.string "name"
    t.integer "pricing_model_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["pricing_model_id"], name: "index_clients_on_pricing_model_id"
  end

  create_table "discount_clients", force: :cascade do |t|
    t.integer "discount_id"
    t.integer "client_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_discount_clients_on_client_id"
    t.index ["discount_id"], name: "index_discount_clients_on_discount_id"
  end

  create_table "discounts", force: :cascade do |t|
    t.string "attribute_matcher"
    t.integer "amount_cents"
    t.decimal "percentage", precision: 4, scale: 2
    t.string "operator_from"
    t.string "operator_to"
    t.integer "quantity_from"
    t.integer "quantity_to"
    t.boolean "use_persantage", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pricing_models", force: :cascade do |t|
    t.string "pricing_strategy"
    t.integer "amount_cents"
    t.decimal "percentage", precision: 4, scale: 2
    t.boolean "use_persantage", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "storage_objects", force: :cascade do |t|
    t.string "name"
    t.integer "client_id"
    t.integer "price_cents"
    t.decimal "square_foot_size"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_storage_objects_on_client_id"
  end

end
