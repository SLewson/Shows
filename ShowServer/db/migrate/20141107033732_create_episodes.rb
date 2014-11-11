class CreateEpisodes < ActiveRecord::Migration
  def change
    create_table :episodes do |t|
      t.references :show, index: true
      t.string :name
      t.string :description

      t.timestamps
    end
  end
end
