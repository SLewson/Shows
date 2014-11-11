class AddUsersShows < ActiveRecord::Migration
  def change
    create_table :users_shows, id: false do |t|
      t.belongs_to :user
      t.belongs_to :show
    end
  end
end
