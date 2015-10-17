require 'nokogiri'
require 'open-uri'

module WalterBishop
  class Reese
    def self.torrent_url_for(search_term)
      # Prepare search
      prepared_search_term = search_term.split(' ').map(&:downcase).join('+')
      torrent_site_url = "https://pirateproxy.tf/s/?q=#{prepared_search_term}&page=0&orderby=99"
      torrent_site_uri = URI.escape(torrent_site_url)

      # Retreive results
      document = Nokogiri::HTML(open(torrent_site_url))
      results = document.css('#searchResult tr')[1..-1]
      return unless results.present? && results.any?

      # Get the torrent
      results_data = results.map do |result|
        {
          url: result.css('td')[1].css('a')[0].attributes["href"].content,
          lv: result.css('td')[2].content.to_i
        }
      end
      result = results_data.sort { |a,b| b[:lv] <=> a[:lv] }.first
      result_url = "https://pirateproxy.tf#{result[:url]}"

      # Get the torrent URL
      result_url.gsub!("[", "%5B")
      result_url.gsub!("]", "%5D")
      result_document = Nokogiri::HTML(open(URI.escape(result_url)))
      torrent_link = result_document.css('#details .download').first.css('a').first
      torrent_url = torrent_link.attributes["href"].content

      # Return
      torrent_url
    end
  end
end
