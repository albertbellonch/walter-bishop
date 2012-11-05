every 1.day, :at => '11:00 pm' do
  runner 'WalterBishop::Sherlock.fetch_next_episodes'
end
