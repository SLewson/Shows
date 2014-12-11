class RenameUsersEpisodesToEpisodesUsers < ActiveRecord::Migration
  def change
    rename_table :user_episodes, :episodes_users
  end
end
