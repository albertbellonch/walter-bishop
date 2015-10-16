every 1.day, :at => '11:00 pm' do
  runner 'WalterBishop::Sherlock.fetch_next_episodes'
end

every 1.hour do
  runner 'WalterBishop::Bubbles.move_finished_episodes'
end
