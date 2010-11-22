class Magazine < ActiveRecord::Base
  has_many :pages
  validates_attachment_presence :cover              
  validates_attachment_content_type :cover, :content_type=>['image/jpeg', 'image/png', 'image/gif']
  validates_presence_of :title, :number_of_pages
  validates_uniqueness_of :title
  has_attached_file :cover , 
                    :styles => { :medium => "300x300", :thumb => "100x100"},
                    :url => "/system/:class/:id/:style_:basename.:extension" , 
                    :path => ":rails_root/public/system/:class/:id/:style_:basename.:extension"

end
