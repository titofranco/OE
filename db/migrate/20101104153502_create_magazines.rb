class CreateMagazines < ActiveRecord::Migration
  def self.up
    create_table :magazines do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :magazines
  end
end
