class MagazinePage < ActiveRecord::Base
  belongs_to :magazine
  has_many :page_magazines
  has_attached_file :image , 
                    :styles => { :medium => "300x300", :thumb => "100x100"},
                    :url => "/system/magazine/:class/:style/:basename.:extension",
                    :path => ":rails_root/public/system/magazine/:class/:style/:basename.:extension"
                    
                    
end
