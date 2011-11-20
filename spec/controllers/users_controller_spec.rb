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
  
  describe "GET 'edit'" do

    before(:each) do
      @user = Factory(:user)
      test_sign_in(@user)
    end

    it "should be successful" do
      get :edit, :id => @user
      response.should be_success
    end

  end
  
  describe "PUT 'update'" do
  		before(:each) do
  			@user = Factory(:user)
  			test_sign_in(@user)
  		end
  		
  		describe "failure" do
  			before(:each) do
  				@attr = {:email => "", :name => "", :password => "",
  							:password_confirmation => ""}
  			end
  			
  			it "should render the 'edit' page" do
	        put :update, :id => @user, :user => @attr
	        response.should render_template('edit')
	      end
		 end
		 
		describe "success" do

	      before(:each) do
	        @attr = { :name => "New Name", :email => "user@example.org",
	                  :password => "barbaz", :password_confirmation => "barbaz" }
	      end
	
	      it "should change the user's attributes" do
	        put :update, :id => @user, :user => @attr
	        @user.reload
	        @user.name.should  == @attr[:name]
	        @user.email.should == @attr[:email]
	      end
	
	      it "should redirect to the user show page" do
	        put :update, :id => @user, :user => @attr
	        response.should redirect_to(user_path(@user))
	      end
	
	      it "should have a flash message" do
	        put :update, :id => @user, :user => @attr
	        flash[:success].should =~ /updated/
	      end
   	end
  	end 
  
  describe "authentication of edit/update pages" do
		before(:each) do
			@user = Factory(:user)
		end  
		describe "for non-signed-in users" do
			it "should deny access to 'edit'" do
				get :edit, :id => @user
				response.should redirect_to(signin_path)
			end
			
			it "should deny access to 'update'" do
				put :update, :id => @user, :user => {}
				response.should redirect_to(signin_path)
			end
		end
  end
end
