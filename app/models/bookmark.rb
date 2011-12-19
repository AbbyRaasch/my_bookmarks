class Bookmark < ActiveRecord::Base
	attr_accessible :URL
	
	has_many :users_bookmarks
	has_many :users, :through => :users_bookmarks	
	
	validates :URL, :presence => true, :length => {:maximum => 49}
	#validates :user_id, :presence => true
	
	default_scope :order => 'bookmarks.created_at DESC'
end
