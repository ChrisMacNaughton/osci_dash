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

ActiveRecord::Schema.define(version: 2019_04_03_123750) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "build_results", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.boolean "manual", default: false
    t.boolean "passed"
    t.text "url"
    t.text "ubuntu_release"
    t.text "openstack_release"
    t.interval "duration"
    t.datetime "ran_at"
    t.uuid "build_id"
    t.uuid "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "note"
    t.boolean "pending"
    t.index ["build_id"], name: "index_build_results_on_build_id"
    t.index ["user_id"], name: "index_build_results_on_user_id"
  end

  create_table "builds", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.text "display_name"
    t.integer "build_number"
    t.text "url"
    t.interval "duration"
    t.boolean "passed"
    t.uuid "job_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["job_id"], name: "index_builds_on_job_id"
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id"
    t.index ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type"
  end

  create_table "job_matrices", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.text "name"
    t.text "filter"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "rename_filter"
  end

  create_table "jobs", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.text "name"
    t.uuid "job_matrix_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["job_matrix_id"], name: "index_jobs_on_job_matrix_id"
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "username", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "build_results", "builds"
  add_foreign_key "build_results", "users"
  add_foreign_key "builds", "jobs"
  add_foreign_key "jobs", "job_matrices"
end
