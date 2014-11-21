class AddDescriptionAndGenreToShows < ActiveRecord::Migration
  def change
    add_column :shows, :description, :string
    add_column :shows, :genre, :string
  end
end
