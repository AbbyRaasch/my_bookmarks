require 'spec_helper'

describe "LayoutLinks" do
  
  
  it "should have a signup page at '/signup'" do
    get '/signup'
    response.should have_selector('title', :content => "Sign up")
  end
  
  describe "when not signed in" do
    it "should have a signup link" do
      visit root_path
      response.should have_selector("a", :href => signup_path,
                                         :content => "Sign up")
    end
  end

  describe "when signed up" do

    before(:each) do
      @user = Factory(:user)
      visit signup_path
      fill_in :email,    :with => @user.email
      fill_in :password, :with => @user.password
      click_button
    end

  end
end
