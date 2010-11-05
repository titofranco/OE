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

ActiveRecord::Schema.define(:version => 20101105153401) do

  create_table "magazine_pages", :force => true do |t|
    t.integer  "magazine_id",                                           :null => false
    t.integer  "page_number",                                           :null => false
    t.datetime "created_at",         :default => '2010-11-05 12:21:23'
    t.datetime "updated_at",         :default => '2010-11-05 12:21:23'
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  add_index "magazine_pages", ["magazine_id"], :name => "fk_magazine_pages"

  create_table "magazines", :force => true do |t|
    t.string   "title",                                                 :null => false
    t.string   "number_of_pages",                                       :null => false
    t.string   "publisher"
    t.string   "tags"
    t.date     "release_date"
    t.datetime "created_at",         :default => '2010-11-04 20:23:12'
    t.datetime "updated_at",         :default => '2010-11-04 20:23:12'
    t.string   "cover_file_name"
    t.string   "cover_content_type"
    t.integer  "cover_file_size"
    t.datetime "cover_updated_at"
  end

end
