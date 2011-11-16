class SessionsController < ApplicationController
	protect_from_forgery
  include SessionsHelper
  def new
 	 @bookmark = Bookmark.new if signed_in?
 	 #@feed_items = current_user.feed.paginate(:page =>[:page])
  end
  
  def create
  	user = User.authenticate(params[:session][:email],
                             params[:session][:password])
    if user.nil?
      flash.now[:error] = "Invalid email/password combination."
      @title = "Sign in"
      render 'new'
    else
      # Sign the user in and redirect to the user's show page.
      sign_in user
      #redirect_to user
      redirect_to root_path
    end
  end
  
  def destroy
    sign_out
    redirect_to root_path
  end

end
