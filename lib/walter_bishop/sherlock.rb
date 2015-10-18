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
          calendar_uri = "http://www.pogdesign.co.uk/cat/download_ics/#{Rails.application.secrets.pogdesign_cat_id}.ics"
          calendar_file = open(calendar_uri) { |f| f.read }
          calendars = Icalendar.parse(calendar_file)
          calendars.first
        end
      end
    end
  end
end
