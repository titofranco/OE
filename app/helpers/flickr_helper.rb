module FlickrHelper  
  def user_photos(user_id, photo_count = 12)
    flickr = Flickr.new(File.join(RAILS_ROOT, 'config', 'flickr.yml'))
    photos = flickr.photos.search(:user_id => user_id)
    #onesinglephoto = flickr.photos.find_by_id('3016262284')
    #puts "ONE SINGLE PHOTO #{onesinglephoto.inspect}"
    if photos.length < photo_count
       photo_count = photos.length
    end    
   # photosets = flickr.photosets.get_list(:user_id => user_id)    
   # puts "WHAT ARE PHOTOSETS #{photos.inspect}"
    photos = photos.values_at(0..(photo_count - 1)) 
    return photos
  end
  
  def one_photo 
    flickr = Flickr.new(File.join(RAILS_ROOT, 'config', 'flickr.yml'))
    onesinglephoto = flickr.photos.find_by_id('3016262284')
    photosets = flickr.photosets.get_list(:user_id => '12864272@N02')
    puts "PHOTOSET #{photosets.inspect}"
    return onesinglephoto
  end
  
  def render_flickr_sidebar_widget(user_id, photo_count = 12, columns = 2)
    begin
      photos = user_photos(user_id, photo_count).in_groups_of(2)
      render :partial => '/flickr/sidebar_widget', :locals => { :photos => photos }
    rescue Exception
      render :partial => '/flickr/unavailable'
    end
  end
  
  def render_one_photo
      onesinglephoto = one_photo
      puts "QUE VA HOME #{onesinglephoto}"
      render :partial => '/flickr/one_photo', :locals => {:photo => onesinglephoto}
  end
  
end
