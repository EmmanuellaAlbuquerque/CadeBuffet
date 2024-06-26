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

ActiveRecord::Schema[7.1].define(version: 2024_05_28_170202) do
  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "base_prices", force: :cascade do |t|
    t.float "min_price"
    t.integer "chosen_category_day"
    t.float "extra_price_per_person"
    t.float "extra_price_per_duration"
    t.integer "event_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_base_prices_on_event_id"
  end

  create_table "buffet_owners", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_buffet_owners_on_email", unique: true
    t.index ["reset_password_token"], name: "index_buffet_owners_on_reset_password_token", unique: true
  end

  create_table "buffet_payment_methods", force: :cascade do |t|
    t.integer "payment_method_id", null: false
    t.integer "buffet_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["buffet_id"], name: "index_buffet_payment_methods_on_buffet_id"
    t.index ["payment_method_id"], name: "index_buffet_payment_methods_on_payment_method_id"
  end

  create_table "buffets", force: :cascade do |t|
    t.string "trading_name"
    t.string "company_name"
    t.string "registration_number"
    t.string "phone"
    t.string "email"
    t.string "address"
    t.string "neighborhood"
    t.string "state"
    t.string "city"
    t.string "zipcode"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "buffet_owner_id", null: false
    t.integer "status", default: 1
    t.index ["buffet_owner_id"], name: "index_buffets_on_buffet_owner_id"
  end

  create_table "chats", force: :cascade do |t|
    t.integer "order_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_chats_on_order_id"
  end

  create_table "clients", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "name"
    t.string "itin"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_clients_on_email", unique: true
    t.index ["itin"], name: "index_clients_on_itin", unique: true
    t.index ["reset_password_token"], name: "index_clients_on_reset_password_token", unique: true
  end

  create_table "event_service_options", force: :cascade do |t|
    t.integer "event_id", null: false
    t.integer "service_option_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_event_service_options_on_event_id"
    t.index ["service_option_id"], name: "index_event_service_options_on_service_option_id"
  end

  create_table "events", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.integer "qty_min"
    t.integer "qty_max"
    t.integer "duration"
    t.string "menu"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "buffet_id", null: false
    t.boolean "exclusive_location", default: false
    t.integer "status", default: 1
    t.index ["buffet_id"], name: "index_events_on_buffet_id"
  end

  create_table "messages", force: :cascade do |t|
    t.text "content"
    t.integer "chat_id", null: false
    t.string "sender_type", null: false
    t.integer "sender_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["chat_id"], name: "index_messages_on_chat_id"
    t.index ["sender_type", "sender_id"], name: "index_messages_on_sender"
  end

  create_table "order_evaluations", force: :cascade do |t|
    t.integer "order_id", null: false
    t.integer "rating"
    t.string "service_opinion"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_order_evaluations_on_order_id"
  end

  create_table "order_payments", force: :cascade do |t|
    t.integer "order_id", null: false
    t.integer "extra_tax", default: 0
    t.integer "discount", default: 0
    t.string "description"
    t.date "validity_date"
    t.integer "payment_method_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "standard_price"
    t.boolean "special_sale", default: false
    t.index ["order_id"], name: "index_order_payments_on_order_id"
    t.index ["payment_method_id"], name: "index_order_payments_on_payment_method_id"
  end

  create_table "orders", force: :cascade do |t|
    t.integer "buffet_id", null: false
    t.integer "event_id", null: false
    t.date "event_date"
    t.integer "qty_invited"
    t.string "event_details"
    t.string "code"
    t.string "event_address"
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "client_id", null: false
    t.index ["buffet_id"], name: "index_orders_on_buffet_id"
    t.index ["client_id"], name: "index_orders_on_client_id"
    t.index ["event_id"], name: "index_orders_on_event_id"
  end

  create_table "payment_methods", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "penalties", force: :cascade do |t|
    t.integer "days_ago"
    t.integer "value_percentage"
    t.integer "event_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_penalties_on_event_id"
  end

  create_table "sales", force: :cascade do |t|
    t.string "name"
    t.date "start_date"
    t.date "end_date"
    t.integer "discount_percentage"
    t.boolean "on_weekdays"
    t.boolean "on_weekend"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "event_id", null: false
    t.integer "buffet_id", null: false
    t.index ["buffet_id"], name: "index_sales_on_buffet_id"
    t.index ["event_id"], name: "index_sales_on_event_id"
  end

  create_table "service_options", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "base_prices", "events"
  add_foreign_key "buffet_payment_methods", "buffets"
  add_foreign_key "buffet_payment_methods", "payment_methods"
  add_foreign_key "buffets", "buffet_owners"
  add_foreign_key "chats", "orders"
  add_foreign_key "event_service_options", "events"
  add_foreign_key "event_service_options", "service_options"
  add_foreign_key "events", "buffets"
  add_foreign_key "messages", "chats"
  add_foreign_key "order_evaluations", "orders"
  add_foreign_key "order_payments", "orders"
  add_foreign_key "order_payments", "payment_methods"
  add_foreign_key "orders", "buffets"
  add_foreign_key "orders", "clients"
  add_foreign_key "orders", "events"
  add_foreign_key "penalties", "events"
  add_foreign_key "sales", "buffets"
  add_foreign_key "sales", "events"
end
