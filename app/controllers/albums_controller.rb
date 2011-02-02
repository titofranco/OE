class AlbumsController < ApplicationController
require 'open-uri'
  API_KEY = "891fffe180dca4fb47cca2b4a3bb6ec3"
  SHARED_SECRET = "98352d68fc4db45a" 
  
  before_filter :authenticate

  def authenticate
    flickr_cache = File.join(RAILS_ROOT, 'config', 'flickr.cache')
    @flickr = Flickr.new(flickr_cache,API_KEY,SHARED_SECRET)
    #user = flickr.people.findByUsername("titofranco")  
  end
  
  def covers
    unless read_fragment(:action=>'covers')
      check_ps_cache
      @photosets = Photoset.find(:all)
    end        
  end
 
  def show_photos
    photoset_id = params[:id] 
    @photos = @flickr.photosets.getPhotos(photoset_id.to_s)
  end

  private
  
  def check_ps_cache
    #caching usually is for production, but meanwhile you can work on development mode
    if ENV['RAILS_ENV'] == 'production'
      authenticate
      @photosets = @flickr.photosets.getList 
      @covers = Array.new
      @db_photosets = Array.new
      for photoset in @photosets do
          @covers << @flickr.photosets.getPhotos(photoset.id.to_s,"1","1")
      end
      @covers.flatten!          
      Photoset.all.each{ |p| @db_photosets.push(p.photoset_id)}

      #ask if the cover is in db
      for i in 0 ... @photosets.length
        if !@db_photosets.include?(@photosets[i].id)                  
          new_photoset = Photoset.new
          new_photoset.photoset_id = @photosets[i].id
          new_photoset.photo_count = @photosets[i].photo_count 
          new_photoset.title = @photosets[i].title
          new_photoset.description = @photosets[i].description
          new_photoset.url = @covers[i].flickr.photos.getInfo(@covers[i].id).urls.values[0]
          puts "COMO QUEDO ESTO: #{new_photoset.inspect}"
          new_photoset.save 
          open(File.expand_path("#{RAILS_ROOT}/public/system/flickr_ps_cache/small/" + new_photoset.photoset_id  + ".jpg"),"w").write(open(@covers[i].url('s')).read)
          open(File.expand_path("#{RAILS_ROOT}/public/system/flickr_ps_cache/large/" + new_photoset.photoset_id + ".jpg"),"w").write(open(@covers[i].url).read)
        end            
      end  
    end
  end
  
end
