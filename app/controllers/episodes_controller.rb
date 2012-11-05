class EpisodesController < ApplicationController
  def index
    @episodes = Episode.newest_first
  end
end
