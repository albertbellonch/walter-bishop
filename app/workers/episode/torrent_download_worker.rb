class Episode::TorrentDownloadWorker
  include Sidekiq::Worker

  def perform(episode_id)
    episode = Episode.find(id)
    if torrent_url = WalterBishop::Reese.torrent_url_for(episode.term_for_torrent_site)
      # enqueue download and mark as downloading
    else
      enqueue_in(2.hours, episode_id)
    end
  end
end
