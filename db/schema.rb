# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_06_13_124645) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "actualiseds", force: :cascade do |t|
    t.datetime "update_ate"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "order_products", force: :cascade do |t|
    t.bigint "product_id", null: false
    t.bigint "order_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "quantity_product", null: false
    t.integer "rack"
    t.index ["order_id"], name: "index_order_products_on_order_id"
    t.index ["product_id"], name: "index_order_products_on_product_id"
  end

  create_table "orders", force: :cascade do |t|
    t.float "total_price"
    t.string "supplier"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "delivered_date"
    t.string "order_reference"
    t.integer "quantity"
    t.bigint "shop_id"
    t.index ["shop_id"], name: "index_orders_on_shop_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.float "buy_price"
    t.string "category"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "ean"
  end

  create_table "sell_products", force: :cascade do |t|
    t.bigint "sell_id", null: false
    t.bigint "shop_product_id", null: false
    t.integer "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "sold_date", default: -> { "CURRENT_TIMESTAMP" }
    t.index ["sell_id"], name: "index_sell_products_on_sell_id"
    t.index ["shop_product_id"], name: "index_sell_products_on_shop_product_id"
  end

  create_table "sells", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.float "total_price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_sells_on_user_id"
  end

  create_table "shop_products", force: :cascade do |t|
    t.bigint "shop_id", null: false
    t.bigint "product_id", null: false
    t.integer "stock"
    t.float "selling_price"
    t.integer "max_stock"
    t.float "rating"
    t.date "dlc"
    t.string "rack"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "status"
    t.boolean "permanent"
    t.index ["product_id"], name: "index_shop_products_on_product_id"
    t.index ["shop_id"], name: "index_shop_products_on_shop_id"
  end

  create_table "shops", force: :cascade do |t|
    t.string "name"
    t.text "address"
    t.float "surface"
    t.integer "capacity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_shops", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "shop_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["shop_id"], name: "index_user_shops_on_shop_id"
    t.index ["user_id"], name: "index_user_shops_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "photo", default: "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_640.png"
    t.boolean "dark_mode", default: false
    t.boolean "admin", default: false, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "order_products", "orders"
  add_foreign_key "order_products", "products"
  add_foreign_key "sell_products", "sells"
  add_foreign_key "sell_products", "shop_products"
  add_foreign_key "sells", "users"
  add_foreign_key "shop_products", "products"
  add_foreign_key "shop_products", "shops"
  add_foreign_key "user_shops", "shops"
  add_foreign_key "user_shops", "users"
end
