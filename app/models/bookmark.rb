class Bookmark < ActiveRecord::Base
	attr_accessible :URL
	
	belongs_to :user
	
	validates :URL, :presence => true, :length => {:maximum => 49}
	validates :user_id, :presence => true
	
	default_scope :order => 'bookmarks.created_at DESC'
end
