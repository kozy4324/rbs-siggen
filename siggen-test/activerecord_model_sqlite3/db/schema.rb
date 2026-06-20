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

ActiveRecord::Schema[8.1].define(version: 2026_06_20_000003) do
  create_table "accounts", primary_key: "account_code", id: :string, force: :cascade do |t|
    t.string "name"
  end

  create_table "articles", id: :string, force: :cascade do |t|
    t.string "name"
  end

  create_table "authors", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name"
    t.datetime "updated_at", null: false
  end

  create_table "post_tags", id: false, force: :cascade do |t|
    t.integer "post_id", null: false
    t.string "tag_name", null: false
  end

  create_table "posts", force: :cascade do |t|
    t.integer "author_id"
    t.text "body"
    t.datetime "created_at", null: false
    t.virtual "engagement_count", type: :integer, as: "likes_count + views_count", stored: true
    t.integer "likes_count"
    t.json "metadata"
    t.decimal "price"
    t.boolean "published"
    t.date "published_on"
    t.float "rating"
    t.virtual "slug", type: :string, as: "lower(title)", stored: true
    t.time "start_time"
    t.binary "thumbnail"
    t.string "title"
    t.datetime "updated_at", null: false
    t.bigint "views_count"
    t.index ["author_id"], name: "index_posts_on_author_id"
  end

  create_table "profiles", force: :cascade do |t|
    t.integer "author_id", null: false
    t.string "avatar_url"
    t.text "bio"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "website_url"
    t.index ["author_id"], name: "index_profiles_on_author_id"
  end

  create_table "taggings", primary_key: ["post_id", "tag_id"], force: :cascade do |t|
    t.string "context"
    t.integer "post_id", null: false
    t.integer "tag_id", null: false
  end

  add_foreign_key "posts", "authors"
  add_foreign_key "profiles", "authors"
end
