class Episode::FetchUpcomingWorker
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  recurrence do
    daily.hour_of_day(12)
  end

  def perform(_, _)
    Episode.fetch_upcoming!
  end
end
