class CreateUsersBookmarks < ActiveRecord::Migration
  def self.up
    create_table :users_bookmarks do |t|
      t.integer :user_id
      t.integer :bookmark_id

      t.timestamps
    end
  end

  def self.down
    drop_table :users_bookmarks
  end
end
