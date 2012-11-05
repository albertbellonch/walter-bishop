class GetTorrentForEpisodeWorker
  include Sidekiq::Worker

  def perform(episode_id)
  end
end
