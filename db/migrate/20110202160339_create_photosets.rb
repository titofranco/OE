class CreatePhotosets < ActiveRecord::Migration
  def self.up
    create_table :photosets do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :photosets
  end
end
