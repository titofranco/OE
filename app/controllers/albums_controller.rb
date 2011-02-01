class AlbumsController < ApplicationController

  before_filter :authenticate

  def authenticate
    flickr_cache = File.join(RAILS_ROOT, 'config', 'flickr.cache')
    flickr = Flickr.new(flickr_cache,API_KEY,SHARED_SECRET)
    user = flickr.people.findByUsername("titofranco")  
  end

end
