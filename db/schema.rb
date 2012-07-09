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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120708153721) do

  create_table "albums", :force => true do |t|
    t.string   "title",       :null => false
    t.text     "description"
    t.string   "path"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "albums", ["id"], :name => "index_albums_on_id", :unique => true

  create_table "bucket_albums", :force => true do |t|
    t.integer  "bucket_id"
    t.integer  "album_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "bucket_albums", ["album_id"], :name => "index_bucket_albums_on_album_id"
  add_index "bucket_albums", ["bucket_id"], :name => "index_bucket_albums_on_bucket_id"

  create_table "buckets", :force => true do |t|
    t.string   "title",       :null => false
    t.string   "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "buckets", ["id"], :name => "index_buckets_on_id", :unique => true

  create_table "photo_tags", :force => true do |t|
    t.integer  "photo_id"
    t.integer  "tag_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "photo_tags", ["photo_id"], :name => "index_photo_tags_on_photo_id"
  add_index "photo_tags", ["tag_id"], :name => "index_photo_tags_on_tag_id"

  create_table "photos", :force => true do |t|
    t.string   "title",       :null => false
    t.text     "description"
    t.integer  "album_id"
    t.string   "file"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "photos", ["album_id"], :name => "index_photos_on_album_id"
  add_index "photos", ["id"], :name => "index_photos_on_id", :unique => true

  create_table "tags", :force => true do |t|
    t.string   "title",      :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "tags", ["id"], :name => "index_tags_on_id", :unique => true

end
