class RenameUsersShowsToShowsUsers < ActiveRecord::Migration
  def change
    rename_table :users_shows, :shows_users
  end
end
