class AddTorrentUrlToEpisodes < ActiveRecord::Migration
  def change
    add_column :episodes, :torrent_url, :string
  end
end
