require 'spec_helper'

describe UsersBookmarks do
  before(:each) do
  		@user = Factory(:user)
  		@bookmark = Factory(:bookmark)
  		@users_bookmarks = @user.users_bookmarks.build(:user_id => @user.id)
  end
  it "should create a new instance given valid attributes" do
  		@users_bookmarks.save!
  end
end
