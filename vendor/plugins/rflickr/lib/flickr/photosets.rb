# rFlickr: A Ruby based Flickr API implementation.
# Copyright (C) 2009, Alex Pardoe (digital:pardoe)
#
# Derrived from work by Trevor Schroeder, see here:
# http://rubyforge.org/projects/rflickr/.
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.

require 'flickr/base'

class Flickr::PhotoSets < Flickr::APIBase
	# photoset can be a PhotoSet or a a photoset id
	# photo can be a Photo or a photo id
	def addPhoto(photoset,photo)
		photo = photo.id if photo.class == Flickr::Photo
		photoset = photoset.id if photoset.class == Flickr::PhotoSet

		@flickr.call_method('flickr.photosets.addPhoto',
			'photoset_id' => photoset, 'photo_id' => photo)
	end

	def create(title,primary_photo, description = nil)
		primary_photo = primary_photo.id if
		primary_photo.class == Flickr::Photo
		args = { 'title' => title, 'primary_photo_id' =>
			  primary_photo}
		args['description'] = description if description
		res = @flickr.call_method('flickr.photosets.create',args)
		id = res.elements['/photoset'].attributes['id']
		url = res.elements['/photoset'].attributes['url']
		set = Flickr::PhotoSet.new(id,@flickr)
		set.title = title
		set.url = url
		@flickr.photoset_cache_store(set)
		return set
	end

	def delete(photoset)
		photoset = photoset.id if photoset.class == Flickr::PhotoSet
		@flickr.call_method('flickr.photosets.delete',
			'photoset_id' => photoset)
	end

	def editMeta(photoset,title,description=nil)
		photoset = photoset.id if photoset.class == Flickr::PhotoSet
		args = {'photoset_id' => photoset,
			'title' => title}
		args['description' ] = description if description
		@flickr.call_method('flickr.photosets.editMeta',args)
	end

	def editPhotos(photoset,primary_photo,photos)
		photoset = photoset.id if photoset.class == Flickr::PhotoSet
		primary_photo = primary_photo.id if
		primary_photo.class == Flickr::Photo
		photos=photos.map{|p| p.id if p.class==Flickr::Photo}.join(',')
		args = {'photoset_id' => photoset,
			'primary_photo_id' => primary_photo,
			'photo_ids' => photos }
		@flickr.call_method('flickr.photosets.editPhotos',args)
	end

	def getContext(photo,photoset)
		photoset = photoset.id if photoset.class == Flickr::PhotoSet
		photo = photo.id if photo.class == Flickr::Photo
		res = @flickr.call_method('flickr.photosets.getContext',
			'photo_id' => photo, 'photoset_id' => photoset)
		return Flickr::Context.from_xml(res,@flickr)
	end

	def getList(user=nil)
		user = user.nsid if user.respond_to?(:nsid)
		args = {}
		args['user_id'] = user if user
		res = @flickr.call_method('flickr.photosets.getList',args)
		list = []
		res.elements['/photosets'].each_element do |el|
		  #puts "The element #{el}"
			list << Flickr::PhotoSet.from_xml(el,@flickr)		
		end
	  #puts "list #{list.inspect}"
		return list.flatten
	end

	def removePhoto(photoset,photo)
		photoset = photoset.id if photoset.class == Flickr::PhotoSet
		photo = photo.id if photo.class == Flickr::Photo
		@flickr.call_method('flickr.photosets.removePhoto',
			'photo_id' => photo, 'photoset_id' => photoset)
	end

	def getPhotos(photoset,per_page=nil,page=nil,extras=nil)
		#photoset = photoset.id if photoset.class == Flickr::PhotoSet
		extras = extras.join(',') if extras.class == Array
		args = { 'photoset_id' => photoset }
		args['extras'] = extras if extras
		args['per_page'] = per_page if per_page
		args['page'] = page if page
		res = @flickr.call_method('flickr.photosets.getPhotos',args)
		#puts "GetPhotos response in XML #{res}"
		return Flickr::PhotoSet.from_xml(res.root,@flickr)
	end

	def getInfo(photoset)
		#photoset = photoset.id if photoset.class == Flickr::PhotoSet
		res = @flickr.call_method('flickr.photosets.getInfo',
			'photoset_id' => photoset)
		return Flickr::PhotoSet.from_xml(res.root,@flickr)
	end

	def orderSets(photosets)
		photosets=photosets.map { |ps|
			(ps.class==Flickr::PhotoSet) ? ps.id : ps}.join(',')
		@flickr.call_method('flickr.photosets.orderSets',
			'photoset_ids' => photosets)
	end
end
