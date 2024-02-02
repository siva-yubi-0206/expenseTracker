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

ActiveRecord::Schema[7.1].define(version: 2024_02_07_083743) do
  create_table "comments", force: :cascade do |t|
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "expense_request_id", null: false
    t.index ["expense_request_id"], name: "index_comments_on_expense_request_id"
  end

  create_table "employees", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "dept"
    t.string "employee_status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "admin_status"
  end

  create_table "expense_group_requests", force: :cascade do |t|
    t.string "title"
    t.integer "applied_amount"
    t.integer "approved_amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "employee_id", null: false
    t.string "status"
    t.index ["employee_id"], name: "index_expense_group_requests_on_employee_id"
  end

  create_table "expense_requests", force: :cascade do |t|
    t.integer "invoice_number"
    t.datetime "date"
    t.text "description"
    t.integer "amount"
    t.string "attachment"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "invoice_validation_result"
    t.integer "expense_group_request_id", null: false
    t.index ["expense_group_request_id"], name: "index_expense_requests_on_expense_group_request_id"
  end

  create_table "replies", force: :cascade do |t|
    t.text "replies"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "comment_id", null: false
    t.index ["comment_id"], name: "index_replies_on_comment_id"
  end

  add_foreign_key "comments", "expense_requests"
  add_foreign_key "expense_group_requests", "employees"
  add_foreign_key "expense_requests", "expense_group_requests"
  add_foreign_key "replies", "comments"
end
