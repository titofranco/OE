class Magazine < ActiveRecord::Base
  has_attached_file :cover , 
                    :styles => { :medium => "300x300", :thumb => "100x100"},
                    :url => "/system/:class/:id/:style/:basename.:extension" , 
                    :path => ":rails_root/public/system/:class/:id/:style/:basename.:extension"

end
=begin
has_attached_file :image,
  :styles => {:thumb => '120x120>', :large => '640x480>' },
  :default_style => :thumb,
  :url => "/system/:class/:attachment/:id/:style/:basename.:extension",
  :path => ":rails_root/public/system/:class/:attachment/:id/:style/:basename.:extension"

 ":rails_root/public/system/:attachment/:id/:style/:filename".
 /data/myapp/releases/20081229172410/public/system/avatars/13/small/my_pic.png
=end
