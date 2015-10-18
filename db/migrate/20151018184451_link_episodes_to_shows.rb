class LinkEpisodesToShows < ActiveRecord::Migration
  def up
    add_column :episodes, :show_id, :integer
    remove_column :episodes, :show
  end

  def down
    add_column :episodes, :show, :string
    remove_column :episodes, :show_id
  end
end
