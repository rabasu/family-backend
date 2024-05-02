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

ActiveRecord::Schema[7.1].define(version: 2024_03_22_173414) do
  create_table "awardings", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.date "year"
    t.bigint "horse_id"
    t.bigint "award_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["award_id"], name: "index_awardings_on_award_id"
    t.index ["horse_id"], name: "index_awardings_on_horse_id"
  end

  create_table "awards", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.string "desc"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "data_migrations", primary_key: "version", id: :string, charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
  end

  create_table "family_lines", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "bloodmare_id"
    t.string "family_number"
    t.string "imported_by"
    t.date "imported_at"
    t.boolean "only_year", default: true, null: false
    t.integer "from"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["bloodmare_id"], name: "index_family_lines_on_bloodmare_id"
  end

  create_table "graded_races", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "code"
    t.string "name"
    t.string "official_name"
    t.string "desc"
    t.integer "breed"
    t.integer "status"
    t.bigint "grade_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["grade_id"], name: "index_graded_races_on_grade_id"
  end

  create_table "grades", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "code"
    t.string "name"
    t.integer "rank"
    t.string "desc"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "horses", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.string "pedigree_name"
    t.date "foaled"
    t.integer "sex"
    t.integer "breed"
    t.integer "group"
    t.bigint "sire_id"
    t.bigint "dam_id"
    t.bigint "family_line_id"
    t.boolean "only_year", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["dam_id"], name: "index_horses_on_dam_id"
    t.index ["family_line_id"], name: "index_horses_on_family_line_id"
    t.index ["sire_id"], name: "index_horses_on_sire_id"
  end

  create_table "racing_records", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.date "date"
    t.bigint "horse_id"
    t.bigint "graded_race_id"
    t.integer "finnish"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["graded_race_id"], name: "index_racing_records_on_graded_race_id"
    t.index ["horse_id"], name: "index_racing_records_on_horse_id"
  end

  add_foreign_key "awardings", "awards"
  add_foreign_key "awardings", "horses"
  add_foreign_key "family_lines", "horses", column: "bloodmare_id"
  add_foreign_key "graded_races", "grades"
  add_foreign_key "horses", "family_lines"
  add_foreign_key "horses", "horses", column: "dam_id"
  add_foreign_key "horses", "horses", column: "sire_id"
  add_foreign_key "racing_records", "graded_races"
  add_foreign_key "racing_records", "horses"
end
