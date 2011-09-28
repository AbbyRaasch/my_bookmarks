class Bookmark < ActiveRecord::Base
    validates :URL, :length => { :minimum => 10 }
    validates :name, :length => { :minimum => 1, :maximum => 100 }
end
