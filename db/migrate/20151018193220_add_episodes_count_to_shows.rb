class AddEpisodesCountToShows < ActiveRecord::Migration
  def change
    add_column :shows, :episodes_count, :integer
  end
end
