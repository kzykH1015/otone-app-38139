# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2022_10_06_061015) do

  create_table "content_creator_relations", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "content_id"
    t.bigint "creator_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["content_id"], name: "index_content_creator_relations_on_content_id"
    t.index ["creator_id"], name: "index_content_creator_relations_on_creator_id"
  end

  create_table "content_genre_relations", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "content_id"
    t.bigint "genre_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["content_id"], name: "index_content_genre_relations_on_content_id"
    t.index ["genre_id"], name: "index_content_genre_relations_on_genre_id"
  end

  create_table "contents", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "title", null: false
    t.integer "category_id", null: false
    t.date "release_date", null: false
    t.text "story_line"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_contents_on_user_id"
  end

  create_table "creators", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "creator_name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "follow_relations", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "follower_id", null: false
    t.integer "followed_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "genres", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "genre_name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "likes", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "content_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["content_id"], name: "index_likes_on_content_id"
    t.index ["user_id"], name: "index_likes_on_user_id"
  end

  create_table "recommends", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "content_id", null: false
    t.integer "recommended_id", null: false
    t.integer "recommender_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["content_id"], name: "index_recommends_on_content_id"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "nickname", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.text "self_introduction", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "content_creator_relations", "contents"
  add_foreign_key "content_creator_relations", "creators"
  add_foreign_key "content_genre_relations", "contents"
  add_foreign_key "content_genre_relations", "genres"
  add_foreign_key "contents", "users"
  add_foreign_key "likes", "contents"
  add_foreign_key "likes", "users"
end
