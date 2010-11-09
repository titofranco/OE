class MagazinePage < ActiveRecord::Base
  belongs_to :magazine
  has_attached_file :image , 
                    :styles => { :medium => "300x300", :thumb => "100x100"},
                    :url => "/system/:class/:id/:style_:basename.:extension",
                    :path => ":rails_root/public/system/:class/:id/:style_:basename.:extension"                 
end
