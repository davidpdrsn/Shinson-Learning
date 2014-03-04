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

ActiveRecord::Schema.define(version: 20140304154337) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "belts", force: true do |t|
    t.string "color"
    t.string "degree"
  end

  create_table "categories", force: true do |t|
    t.string "name"
  end

  create_table "notes", force: true do |t|
    t.text     "text"
    t.integer  "user_id"
    t.integer  "technique_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "question",     default: false
  end

  add_index "notes", ["technique_id"], name: "index_notes_on_technique_id", using: :btree
  add_index "notes", ["user_id"], name: "index_notes_on_user_id", using: :btree

  create_table "questions", force: true do |t|
    t.integer  "technique_id"
    t.integer  "study_round_id"
    t.boolean  "answered_correctly", default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "questions", ["study_round_id"], name: "index_questions_on_study_round_id", using: :btree
  add_index "questions", ["technique_id"], name: "index_questions_on_technique_id", using: :btree

  create_table "studies", force: true do |t|
    t.integer "belt_id"
    t.integer "category_id"
    t.integer "user_id"
  end

  add_index "studies", ["belt_id"], name: "index_studies_on_belt_id", using: :btree
  add_index "studies", ["category_id"], name: "index_studies_on_category_id", using: :btree
  add_index "studies", ["user_id"], name: "index_studies_on_user_id", using: :btree

  create_table "study_rounds", force: true do |t|
    t.integer  "study_set_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "study_rounds", ["study_set_id"], name: "index_study_rounds_on_study_set_id", using: :btree

  create_table "study_sets", force: true do |t|
    t.integer  "category_id"
    t.integer  "belt_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "study_sets", ["belt_id"], name: "index_study_sets_on_belt_id", using: :btree
  add_index "study_sets", ["category_id"], name: "index_study_sets_on_category_id", using: :btree
  add_index "study_sets", ["user_id"], name: "index_study_sets_on_user_id", using: :btree

  create_table "techniques", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "belt_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "category_id"
    t.integer  "user_id"
    t.integer  "notes_count", default: 0, null: false
  end

  add_index "techniques", ["belt_id"], name: "index_techniques_on_belt_id", using: :btree
  add_index "techniques", ["category_id"], name: "index_techniques_on_category_id", using: :btree
  add_index "techniques", ["user_id"], name: "index_techniques_on_user_id", using: :btree

  create_table "users", force: true do |t|
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
    t.string   "first_name"
    t.string   "last_name"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
