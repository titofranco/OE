class Page < ActiveRecord::Base
  belongs_to :magazine
  validates_numericality_of :page_number
  validates_presence_of :page_number
  validates_uniqueness_of :page_number
  validates_attachment_presence :image
  validates_attachment_content_type :image, :content_type=>['image/jpeg', 'image/png', 'image/gif']
  has_attached_file :image , 
                    :styles => { :medium => "300x300", :thumb => "100x100"},
                    :url => "/system/:class/:id/:style_:basename.:extension",
                    :path => ":rails_root/public/system/:class/:id/:style_:basename.:extension"                 
end
