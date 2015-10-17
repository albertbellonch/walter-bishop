desc "Fetch upcoming Episodes"
namespace :walter_bishop do
  task fetch_upcoming: :environment do
    fetched_episodes = Episode.fetch_upcoming!
    puts "[walter_bishop:fetch_upcoming] Fetched #{fetched_episodes} episodes."
  end
end
