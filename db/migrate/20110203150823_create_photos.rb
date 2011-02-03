class CreatePhotos < ActiveRecord::Migration
  def self.up
    create_table :photos do |t|
      t.string :photoset_id ,:limit => 25
      t.string :photo_id, :limit => 25
      t.string :title, :limit => 250
      t.text :description
      t.string :url, :limit => 250
      t.timestamps :default => Time.now
    end
    
    add_index :photos , :photo_id
        
    execute "alter table photos add constraint fk_photos
           foreign key (photoset_id) references photosets(photoset_id)"

  end

  def self.down
    drop_table :photos
  end

end
