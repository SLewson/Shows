class AddHuluVideoIdToEpisode < ActiveRecord::Migration
  def change
    add_column :episodes, :hulu_video_id, :integer
  end
end
