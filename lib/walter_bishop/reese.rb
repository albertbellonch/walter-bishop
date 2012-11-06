# encoding: UTF-8

require 'nokogiri'
require 'open-uri'

module WalterBishop
  class Reese
    def self.get_torrent(episode)
      # Get the results page
      term = episode.identifier_for_pirate_bay
      pirate_bay_url = URI.escape "http://thepiratebay.se/search/#{term}/0/99/0"
      document = Nokogiri::HTML(open(pirate_bay_url))
      results = document.css('#searchResult tr')[1..-1]

      return false unless results.any? # try again in a few hours

      # Get the torrent
      results_data = results.map do |result|
        {
          :url => result.css('td')[1].css('a')[0].attributes["href"].content,
          :lv => result.css('td')[2].content.to_i
        }
      end
      result = results_data.sort { |a,b| b[:lv] <=> a[:lv] }.first
      result_url = "http://thepiratebay.se#{result[:url]}"

      # Get the torrent URL
      result_url.gsub!("[", "%5B")
      result_url.gsub!("]", "%5D")
      result_document = Nokogiri::HTML(open(URI.escape(result_url)))
      torrent_link = result_document.css('#details .download').first.css('a').first
      torrent_url = torrent_link.attributes["href"].content

      # Update the episode
      episode.update_attribute(:torrent_url, torrent_url)

      # Return
      true
    end
  end
end
