namespace :db do
  desc "Fill database with sample data"
  task :populate => :environment do

    2.times do
      User.all(:limit => 4).each do |user|
        user.bookmarks.create!(:URL => "www.google.com")
      end
    end
  end
end
