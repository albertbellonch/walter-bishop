require 'open-uri'

module WalterBishop
  class Sherlock
    RANGE = 1.day

    def self.fetch_next_episodes
      next_episodes.each do |event|
        # Gather information
        info, title = event.summary.split("-").map(&:strip)
        *tv_series, identifier = info.split(" ")
        season, number = identifier.split("x")

        # Create the episode
        Episode.create :title => title, :tv_series => tv_series.join(" "), :season => season, :number => number,
          :start_time => event.dtstart, :end_time => event.dtend
      end.select { |episode| !!episode.id }
    end

    private

    def self.next_episodes
      limit = Time.now + RANGE
      calendar.events.select { |event| event.dtstart <= limit }
    end

    def self.calendar
      @calendar ||= begin
        calendar_file = open('http://www.pogdesign.co.uk/cat/download_ics/b863d321ce2d2c4ffa6a30c4cb17132a.ics') { |f| f.read }
        calendars = Icalendar.parse(calendar_file)
        calendars.first
      end
    end
  end
end
