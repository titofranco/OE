class AlbumsController < ApplicationController
  
  API_KEY = "891fffe180dca4fb47cca2b4a3bb6ec3"
  SHARED_SECRET = "98352d68fc4db45a" 
  
  before_filter :authenticate

  def authenticate
    flickr_cache = File.join(RAILS_ROOT, 'config', 'flickr.cache')
    @flickr = Flickr.new(flickr_cache,API_KEY,SHARED_SECRET)
    #user = flickr.people.findByUsername("titofranco")  
  end
  
  def covers
    @photosets = @flickr.photosets.getList
    @photos = Array.new
    for photoset in @photosets do
       @photos << @flickr.photosets.getPhotos(photoset.id.to_s,"1","1")
    end
    @photos.flatten!   
  end

end
