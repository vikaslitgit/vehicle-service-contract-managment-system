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

ActiveRecord::Schema[7.0].define(version: 2026_05_07_103004) do
  create_table "customers", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email", null: false
    t.string "phone", null: false
    t.date "date_of_birth"
    t.string "address"
    t.string "city"
    t.string "state", null: false
    t.string "zip_code", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_customers_on_email", unique: true
  end

  create_table "service_contracts", force: :cascade do |t|
    t.integer "customer_id", null: false
    t.integer "vehicle_id", null: false
    t.string "contract_number"
    t.string "coverage_type"
    t.string "coverage_duration_months"
    t.integer "deductible_amount"
    t.integer "monthly_payment"
    t.date "start_date"
    t.date "end_date"
    t.string "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["contract_number"], name: "index_service_contracts_on_contract_number", unique: true
    t.index ["customer_id"], name: "index_service_contracts_on_customer_id"
    t.index ["vehicle_id"], name: "index_service_contracts_on_vehicle_id"
  end

  create_table "vehicles", force: :cascade do |t|
    t.integer "customer_id", null: false
    t.string "vin", null: false
    t.date "year"
    t.string "make"
    t.string "model"
    t.string "mileage"
    t.string "color"
    t.date "purchase_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id"], name: "index_vehicles_on_customer_id"
    t.index ["vin"], name: "index_vehicles_on_vin", unique: true
  end

  add_foreign_key "service_contracts", "customers"
  add_foreign_key "service_contracts", "vehicles"
  add_foreign_key "vehicles", "customers"
end
