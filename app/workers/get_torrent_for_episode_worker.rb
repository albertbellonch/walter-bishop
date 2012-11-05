class GetTorrentForEpisodeWorker
  include Sidekiq::Worker

  def perform(episode_id)
    episode = episode.find(episode_id)

    if torrent_url = WalterBishop::Reese.get_torrent(episode)
      # hand it to Tyrion
    else
      GetTorrentForEpisodeWorker.perform_in(2.hours, episode_id)
    end
  end
end