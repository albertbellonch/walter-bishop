class EpisodesController < BaseController
  def index
    @episodes = Episode.all
    @episodes = @episodes.oldest_first

    render json: @episodes
  end
end
