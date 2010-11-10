class CreatePages < ActiveRecord::Migration
  def self.up
    create_table :pages do |t|
      t.integer :magazine_id , :null => false
      t.integer :page_number  , :null => false
      t.timestamps :default => Time.now
      t.string :image_file_name
      t.string :image_content_type
      t.integer :image_file_size
      t.datetime :image_updated_at           
    end
    
    execute "alter table pages add constraint fk_pages 
             foreign key (magazine_id) references magazines(id)"
    
  end

  def self.down
    drop_table :pages
  end
end

