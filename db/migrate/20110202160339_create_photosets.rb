class CreatePhotosets < ActiveRecord::Migration
  def self.up
    create_table :photosets do |t|
      t.string :photoset_id , :limit => 25
      t.integer :photo_count
      t.string :title, :limit => 250
      t.text :description
      t.string :url, :limit => 250
      t.timestamps :default => Time.now
    end
    
    add_index :photosets , :photoset_id
    
  end

  def self.down
    drop_table :photosets
  end
end
