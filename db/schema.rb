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

ActiveRecord::Schema.define(version: 2018_06_05_013333) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

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
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "ballots", force: :cascade do |t|
    t.integer "member_number"
    t.bigint "poll_id"
    t.string "sca_name"
    t.string "modern_name"
    t.text "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["poll_id"], name: "index_ballots_on_poll_id"
  end

  create_table "candidates", force: :cascade do |t|
    t.string "sca_name"
    t.bigint "ticket_id"
    t.index ["ticket_id"], name: "index_candidates_on_ticket_id"
  end

  create_table "groups", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "groups_zipcodes", id: false, force: :cascade do |t|
    t.bigint "group_id"
    t.bigint "zipcode_id"
    t.index ["group_id"], name: "index_groups_zipcodes_on_group_id"
    t.index ["zipcode_id"], name: "index_groups_zipcodes_on_zipcode_id"
  end

  create_table "members", force: :cascade do |t|
    t.string "sca_name"
    t.string "modern_name"
    t.integer "number"
    t.bigint "zipcode_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["zipcode_id"], name: "index_members_on_zipcode_id"
  end

  create_table "polls", force: :cascade do |t|
    t.bigint "group_id"
    t.datetime "start_date"
    t.datetime "end_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id"], name: "index_polls_on_group_id"
  end

  create_table "scores", force: :cascade do |t|
    t.bigint "candidate_id"
    t.bigint "ballot_id"
    t.integer "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ballot_id"], name: "index_scores_on_ballot_id"
    t.index ["candidate_id"], name: "index_scores_on_candidate_id"
  end

  create_table "tickets", force: :cascade do |t|
    t.text "letter_of_intent"
    t.bigint "poll_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["poll_id"], name: "index_tickets_on_poll_id"
  end

  create_table "zipcodes", force: :cascade do |t|
    t.integer "number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "ballots", "polls"
  add_foreign_key "candidates", "tickets"
  add_foreign_key "members", "zipcodes"
  add_foreign_key "polls", "groups"
  add_foreign_key "scores", "ballots"
  add_foreign_key "scores", "candidates"
  add_foreign_key "tickets", "polls"
end
