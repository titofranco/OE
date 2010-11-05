class CreateMagazines < ActiveRecord::Migration
  def self.up
    create_table :magazines do |t|
      t.string :title, :null => false
      t.string :number_of_pages, :null => false
      t.string :publisher
      t.string :tags
      t.date :release_date
      t.timestamps :default => Time.now
      t.string :cover_file_name
      t.string :cover_content_type
      t.integer :cover_file_size
      t.datetime :cover_updated_at
    end
  end

  def self.down
    drop_table :magazines
  end
end
