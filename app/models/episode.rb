class Episode < ActiveRecord::Base
  attr_accessible :end_time, :number, :season, :start_time, :title, :tv_series
end
