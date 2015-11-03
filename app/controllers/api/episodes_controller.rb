class Api::EpisodesController < API::BaseController
  def index
    @episodes = Episode.all.includes(:show).oldest_first

    render json: @episodes
  end
end
