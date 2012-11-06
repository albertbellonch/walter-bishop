module WalterBishop
  class Tyrion
    def self.enqueue_torrent(episode)
      `transmission-remote --auth raspberrypi:piraspberry --add "#{episode.torrent_url}"`
    end
  end
end
