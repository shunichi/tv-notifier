# frozen_string_literal: true

require 'rss'
require 'uri'
require 'pp'

class TvProgram
  def initialize()
  end

  class << self
    def search_url(keyword)
      "https://tv.so-net.ne.jp/rss/schedulesBySearch.action?condition.keyword=#{URI.escape(keyword)}&stationPlatformId=0"
    end

    def search(keyword)
      rss = RSS::Parser.parse(search_url(keyword))
      rss.items.each do |item|
        puts '*********'
        puts "title: #{item.title}"
        puts "description: #{item.description}"
        puts "link: #{item.link}"
      end
    end
  end
end
