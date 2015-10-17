desc "List upcoming Episodes"
namespace :walter_bishop do
  task list_upcoming: :environment do
    if (upcoming_episodes = Episode.upcoming).any?
      puts "[walter_bishop:list_upcoming] Next episodes:"
      upcoming_episodes.oldest_first.each do |episode|
        puts "* #{episode.identifier} [#{episode.starts_at}]"
      end
    else
      puts "[walter_bishop:list_upcoming] No upcoming episodes."
    end
  end
end
