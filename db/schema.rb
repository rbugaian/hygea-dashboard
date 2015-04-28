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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150424074739) do

  create_table "doctors", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "auth_token"
    t.string   "first_name"
    t.string   "last_name"
  end

  add_index "doctors", ["auth_token"], name: "index_doctors_on_auth_token", unique: true
  add_index "doctors", ["email"], name: "index_doctors_on_email", unique: true
  add_index "doctors", ["reset_password_token"], name: "index_doctors_on_reset_password_token", unique: true

  create_table "patients", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "doctor_id"
    t.integer  "personnel_id"
    t.integer  "idno",         limit: 8
    t.integer  "blood_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "ward_id"
  end

  create_table "personnels", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "status"
    t.string   "auth_token"
    t.string   "first_name"
    t.string   "last_name"
  end

  add_index "personnels", ["auth_token"], name: "index_personnels_on_auth_token", unique: true
  add_index "personnels", ["email"], name: "index_personnels_on_email", unique: true
  add_index "personnels", ["reset_password_token"], name: "index_personnels_on_reset_password_token", unique: true

  create_table "tasks", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "status"
    t.integer  "doctor_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "report"
    t.integer  "personnel_id"
    t.datetime "date_to_execute"
    t.boolean  "was_shown"
    t.integer  "patient_id"
  end

  add_index "tasks", ["doctor_id"], name: "index_tasks_on_doctor_id"
  add_index "tasks", ["personnel_id"], name: "index_tasks_on_personnel_id"

  create_table "wards", force: true do |t|
    t.integer  "room_number"
    t.integer  "capacity"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
