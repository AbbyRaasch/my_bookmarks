require 'spec_helper'

describe UsersController do
  render_views
  
  
  
  describe "GET 'show'" do

    before(:each) do
      @user = Factory(:user)
    end

    


  end
  describe "GET 'new'" do
    
    it "should be successful" do
      get 'new'
      response.should be_success
    end

  end
  
  describe "POST 'create'" do

    describe "failure" do

      before(:each) do
        @attr = { :name => "", :real_name => "", :email => "", :password => "",
                  :password_confirmation => "" }
      end

      it "should not create a user" do
        lambda do
          post :create, :user => @attr
        end.should_not change(User, :count)
      end

      it "should render the 'new' page" do
        post :create, :user => @attr
        response.should render_template('new')
      end
    end
    
  end
  
end
