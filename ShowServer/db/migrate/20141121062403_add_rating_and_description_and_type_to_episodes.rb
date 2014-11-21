class AddRatingAndDescriptionAndTypeToEpisodes < ActiveRecord::Migration
  def change
    add_column :episodes, :rating, :double
    add_column :episodes, :type, :string
  end
end
