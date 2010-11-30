module FlickrHelper  
  def user_photos(user_id, photo_count = 12)
    flickr = Flickr.new(File.join(RAILS_ROOT, 'config', 'flickr.yml'))
    photos = flickr.photos.search(:user_id => user_id)
    if photos.length < photo_count
       photo_count = photos.length
    end   
    photos = photos.values_at(0..(photo_count - 1)) 
  end
  
  def render_flickr_sidebar_widget(user_id, photo_count = 12, columns = 2)
    begin
      photos = user_photos(user_id, photo_count).in_groups_of(2)
      render :partial => '/flickr/sidebar_widget', :locals => { :photos => photos }
    rescue Exception
      render :partial => '/flickr/unavailable'
    end
  end
end
