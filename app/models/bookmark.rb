class Bookmark < ActiveRecord::Base
	belongs_to :user
    validates :URL, :length => { :minimum => 10 }
    validates :name, :length => { :minimum => 1, :maximum => 100 }
end
