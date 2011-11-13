require 'spec_helper'

describe Bookmark do
  before(:each) do
    @attr = { :URL => "www.example.com", 
              :name => "Example Name"}
  end
  
  it "should create a new instance given valid attributes" do
    Bookmark.create!(@attr)
  end
end
