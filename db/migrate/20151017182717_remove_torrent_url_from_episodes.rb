class RemoveTorrentUrlFromEpisodes < ActiveRecord::Migration
  def up
    remove_column :episodes, :torrent_url
  end

  def down
    add_column :episodes, :torrent_url, :string
  end
end
