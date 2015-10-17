require 'open-uri'

module WalterBishop
  class Sherlock
    class << self
      RANGE = 7.days

      def upcoming_episodes
        limit = Time.now + RANGE
        calendar.events.select { |event| event.dtstart <= limit }
      end

      def calendar
        @calendar ||= begin
          calendar_file = open('http://www.pogdesign.co.uk/cat/download_ics/b863d321ce2d2c4ffa6a30c4cb17132a.ics') { |f| f.read }
          calendars = Icalendar.parse(calendar_file)
          calendars.first
        end
      end
    end
  end
end
