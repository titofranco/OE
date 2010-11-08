class Magazine < ActiveRecord::Base
  has_many :magazine_pages
  has_attached_file :cover , 
                    :styles => { :medium => "300x300", :thumb => "100x100"},
                    :url => "/system/:class/:id/:style/:basename.:extension" , 
                    :path => ":rails_root/public/system/:class/:id/:style/:basename.:extension"

end
