class AddHuluIdToShow < ActiveRecord::Migration
  def change
    add_column :shows, :hulu_id, :integer
  end
end
