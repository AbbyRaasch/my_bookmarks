require 'spec_helper'

describe Bookmark do
  before(:each) do
  	 @user = Factory(:user)
    @attr = { :URL => "www.example.com"}
  end
  
  it "should create a new instance given valid attributes" do
   # Bookmark.create!(@attr)
   @user.bookmarks.create!(@attr)
  end
  
  describe "user associations" do

    before(:each) do
      @bookmark = @user.bookmarks.create(@attr)
    end

    it "should have a user attribute" do
      @bookmark.should respond_to(:user)
    end

    it "should have the right associated user" do
      @bookmark.user_id.should == @user.id
      @bookmark.user.should == @user
    end
  end
  
  describe "validations" do

    it "should require a user id" do
      Bookmark.new(@attr).should_not be_valid
    end

    it "should require nonblank URL" do
      @user.bookmarks.build(:URL => "  ").should_not be_valid
    end

    it "should reject long content" do
      @user.bookmarks.build(:URL => "a" * 50).should_not be_valid
    end
  end


end
