# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110202160339) do

  create_table "magazines", :force => true do |t|
    t.string   "title",                                                 :null => false
    t.string   "number_of_pages",                                       :null => false
    t.string   "publisher"
    t.string   "tags"
    t.date     "release_date"
    t.datetime "created_at",         :default => '2011-02-02 15:34:37'
    t.datetime "updated_at",         :default => '2011-02-02 15:34:37'
    t.string   "cover_file_name"
    t.string   "cover_content_type"
    t.integer  "cover_file_size"
    t.datetime "cover_updated_at"
  end

  create_table "pages", :force => true do |t|
    t.integer  "magazine_id",                                           :null => false
    t.integer  "page_number",                                           :null => false
    t.datetime "created_at",         :default => '2011-02-02 15:34:38'
    t.datetime "updated_at",         :default => '2011-02-02 15:34:38'
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  add_index "pages", ["magazine_id"], :name => "fk_pages"

  create_table "photosets", :force => true do |t|
    t.string   "photoset_id", :limit => 25
    t.integer  "photo_count"
    t.string   "title",       :limit => 250
    t.text     "description"
    t.string   "url",         :limit => 250
    t.datetime "created_at",                 :default => '2011-02-02 18:10:53'
    t.datetime "updated_at",                 :default => '2011-02-02 18:10:53'
  end

  add_index "photosets", ["photoset_id"], :name => "index_photosets_on_photoset_id"

end
