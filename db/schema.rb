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

ActiveRecord::Schema.define(version: 20160417162228) do

  create_table "collars", force: :cascade do |t|
    t.integer  "pet_id",          limit: 4
    t.string   "collarId",        limit: 255
    t.string   "collarReference", limit: 255
    t.string   "description",     limit: 255
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "collars", ["collarId"], name: "index_collars_on_collarId", using: :btree
  add_index "collars", ["pet_id"], name: "index_collars_on_pet_id", using: :btree

  create_table "nations", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "pet_conditions", force: :cascade do |t|
    t.integer  "pet_id",             limit: 4
    t.string   "ownerEmail",         limit: 255
    t.decimal  "latitude",                       precision: 10, scale: 6
    t.decimal  "longitude",                      precision: 10, scale: 6
    t.integer  "breathingFrequency", limit: 4
    t.integer  "heartFrequency",     limit: 4
    t.integer  "systolicPressure",   limit: 4
    t.integer  "diastolicPressure",  limit: 4
    t.float    "temperature",        limit: 24
    t.datetime "created_at",                                              null: false
    t.datetime "updated_at",                                              null: false
  end

  add_index "pet_conditions", ["ownerEmail"], name: "index_pet_conditions_on_ownerEmail", using: :btree
  add_index "pet_conditions", ["pet_id"], name: "index_pet_conditions_on_pet_id", using: :btree

  create_table "pets", force: :cascade do |t|
    t.integer  "user_id",     limit: 4
    t.string   "name",        limit: 255
    t.string   "gender",      limit: 1
    t.text     "description", limit: 65535
    t.string   "breed",       limit: 255
    t.date     "birthDate"
    t.string   "petStatus",   limit: 255
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "pets", ["user_id"], name: "index_pets_on_user_id", using: :btree

  create_table "records", force: :cascade do |t|
    t.string   "collarId",           limit: 255
    t.decimal  "latitude",                       precision: 10, scale: 6
    t.decimal  "longitude",                      precision: 10, scale: 6
    t.integer  "breathingFrequency", limit: 4
    t.integer  "heartFrequency",     limit: 4
    t.integer  "systolicPressure",   limit: 4
    t.integer  "diastolicPressure",  limit: 4
    t.integer  "temperature",        limit: 4
    t.string   "status",             limit: 255
    t.datetime "created_at",                                              null: false
    t.datetime "updated_at",                                              null: false
  end

  add_index "records", ["collarId"], name: "index_records_on_collarId", using: :btree

  create_table "safe_zones", force: :cascade do |t|
    t.integer  "pet_id",     limit: 4
    t.decimal  "latitude",              precision: 10, scale: 6
    t.decimal  "longitude",             precision: 10, scale: 6
    t.float    "radius",     limit: 24
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
  end

  add_index "safe_zones", ["pet_id"], name: "index_safe_zones_on_pet_id", using: :btree

  create_table "statictis_journalers", force: :cascade do |t|
    t.string   "collarId",             limit: 255
    t.string   "d_unmarshaller_begin", limit: 255
    t.string   "d_unmarshaller_end",   limit: 255
    t.string   "d_journaler_begin",    limit: 255
    t.string   "d_journaler_end",      limit: 255
    t.integer  "t_unmarshaller",       limit: 4
    t.integer  "t_inredis_queue",      limit: 4
    t.integer  "t_journaler",          limit: 4
    t.integer  "t_process",            limit: 4
    t.integer  "t_perception",         limit: 4
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  create_table "statictis_processes", force: :cascade do |t|
    t.string   "collarId",              limit: 255
    t.string   "d_unmarshaller_begin",  limit: 255
    t.string   "d_unmarshaller_end",    limit: 255
    t.string   "d_businesslogic_begin", limit: 255
    t.string   "d_businesslogic_end",   limit: 255
    t.string   "d_output_begin",        limit: 255
    t.string   "d_output_end",          limit: 255
    t.integer  "notify",                limit: 4
    t.integer  "t_unmarshaller",        limit: 4
    t.integer  "t_inredis_queue",       limit: 4
    t.integer  "t_businesslogic",       limit: 4
    t.integer  "t_insqs_queue",         limit: 4
    t.integer  "t_output",              limit: 4
    t.integer  "t_process",             limit: 4
    t.integer  "t_perception",          limit: 4
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",      limit: 255
    t.string   "name",       limit: 255
    t.string   "last_name",  limit: 255
    t.string   "documentId", limit: 255
    t.string   "phone",      limit: 255
    t.string   "cellphone",  limit: 255
    t.integer  "nation_id",  limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["nation_id"], name: "index_users_on_nation_id", using: :btree

  add_foreign_key "collars", "pets"
  add_foreign_key "pet_conditions", "pets"
  add_foreign_key "pets", "users"
  add_foreign_key "safe_zones", "pets"
  add_foreign_key "users", "nations"
end
