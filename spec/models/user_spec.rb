require 'spec_helper'

describe User do
  
  before(:each) do
    @attr = { :name => "Example User", 
              :real_name => "Example Real Name", 
              :email => "user@example.com", 
              :password => "foobarfoo",
	      :password_confirmation => "foobarfoo"}
  end
  
  it "should create a new instance given valid attributes" do
    User.create!(@attr)
  end
  
  it "should require a name" do
    no_name_user = User.new(@attr.merge(:name => ""))
    no_name_user.should_not be_valid
  end
  
  it "should require a real name" do
    no_real_name_user = User.new(@attr.merge(:real_name => ""))
    no_real_name_user.should_not be_valid
  end
  
  it "should require an email address" do
    no_email_user = User.new(@attr.merge(:email => ""))
    no_email_user.should_not be_valid
  end
  
  it "should reject real_names that are too long" do
    long_real_name = "a" * 76
    long_real_name_user = User.new(@attr.merge(:real_name => long_real_name))
    long_real_name_user.should_not be_valid
  end
  
  it "should reject real_names that are too short" do
    short_real_name = "a" * 1
    short_real_name_user = User.new(@attr.merge(:real_name => short_real_name))
    short_real_name_user.should_not be_valid
  end
  
  it "should accept valid email addresses" do
    addresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
    addresses.each do |address|
      valid_email_user = User.new(@attr.merge(:email => address))
      valid_email_user.should be_valid
    end
  end

  it "should reject invalid email addresses" do
    addresses = %w[user@foo,com user_at_foo.org example.user@foo.]
    addresses.each do |address|
      invalid_email_user = User.new(@attr.merge(:email => address))
      invalid_email_user.should_not be_valid
    end
  end
  
  it "should reject duplicate email addresses" do
    # Put a user with given email address into the database.
    User.create!(@attr)
    user_with_duplicate_email = User.new(@attr)
    user_with_duplicate_email.should_not be_valid
  end
  
  it "should reject email addresses identical up to case" do
    upcased_email = @attr[:email].upcase
    User.create!(@attr.merge(:email => upcased_email))
    user_with_duplicate_email = User.new(@attr)
    user_with_duplicate_email.should_not be_valid
  end
  
  it "should reject duplicate name" do
    # Put a user with a given name into the database.
    
    User.create!(@attr)
    user_with_duplicate_name = User.new(@attr)
    user_with_duplicate_name.should_not be_valid
  end
  
  it "should reject name identical up to case" do
    upcased_name = @attr[:name].upcase
    User.create!(@attr.merge(:name => upcased_name))
    user_with_duplicate_name = User.new(@attr)
    user_with_duplicate_name.should_not be_valid
  end
  
  describe "password validations" do

    it "should require a password" do
      User.new(@attr.merge(:password => "", :password_confirmation => "")).
        should_not be_valid
    end

    it "should require a matching password confirmation" do
      User.new(@attr.merge(:password_confirmation => "invalid")).
        should_not be_valid
    end

    it "should reject short passwords" do
      short = "a" * 6
      hash = @attr.merge(:password => short, :password_confirmation => short)
      User.new(hash).should_not be_valid
    end

    it "should reject long passwords" do
      long = "a" * 41
      hash = @attr.merge(:password => long, :password_confirmation => long)
      User.new(hash).should_not be_valid
    end
  end
  
  describe "password encryption" do

    before(:each) do
      @user = User.create!(@attr)
    end

    it "should have an encrypted password attribute" do
      @user.should respond_to(:encrypted_password)
    end
    
    it "should set the encrypted password" do
      @user.encrypted_password.should_not be_blank
    end
    
    describe "has_password? method" do

      it "should be true if the passwords match" do
        @user.has_password?(@attr[:password]).should be_true
      end    

      it "should be false if the passwords don't match" do
        @user.has_password?("invalid").should be_false
      end 
    end
    describe "authenticate method" do

      it "should return nil on email/password mismatch" do
        wrong_password_user = User.authenticate(@attr[:email], "wrongpass")
        wrong_password_user.should be_nil
      end

      it "should return nil for an email address with no user" do
        nonexistent_user = User.authenticate("bar@foo.com", @attr[:password])
        nonexistent_user.should be_nil
      end

      it "should return the user on email/password match" do
        matching_user = User.authenticate(@attr[:email], @attr[:password])
        matching_user.should == @user
      end
    end
  end
  describe "bookmarks associations" do

    before(:each) do
      @user = User.create(@attr)
      @bm1 = Factory(:bookmark, :user => @user, :created_at => 1.day.ago)
      @bm2 = Factory(:bookmark, :user => @user, :created_at => 1.hour.ago)
    end

	    it "should have a bookmarks attribute" do
	      @user.should respond_to(:bookmarks)
	    end
	    
	    it "should have the right bookmarks in the right order" do
			@user.bookmarks.should == [@bm2, @bm1]    
	    end
	    
	    it "should destroy associated bookmarks" do
	      @user.destroy
	      [@bm1, @bm2].each do |bookmark|
	        Bookmark.find_by_id(bookmark.id).should be_nil
	    end
  end
    
    describe "status feed" do

      it "should have a feed" do
        @user.should respond_to(:feed)
      end

      it "should include the user's bookmarks" do
        @user.feed.include?(@bm1).should be_true
        @user.feed.include?(@bm2).should be_true
      end

      it "should not include a different user's bookmarks" do
        bm3 = Factory(:bookmark,
                      :user => Factory(:user, :email => Factory.next(:email)))
        @user.feed.include?(bm3).should be_false
      end
    end

  end

end
