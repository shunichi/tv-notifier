# frozen_string_literal: true

require 'rss'
require 'uri'
require 'pp'

class TvProgram
  class Collector
    Item = Struct.new(:title, :date, :description, :link)

    class << self
      def search_url(keyword)
        "https://tv.so-net.ne.jp/rss/schedulesBySearch.action?condition.keyword=#{URI.escape(keyword)}&stationPlatformId=0"
      end

      def search_raw(keyword)
        rss = RSS::Parser.parse(search_url(keyword))
        rss.items
      rescue RSS::MissingTagError
        []
      end

      def search(keyword)
        items = search_raw(keyword)
        items.map do |item|
          link = item.link.gsub(/\Ahttp:/, 'https:').gsub(/\?from=rss\z/, '')
          Item.new(item.title, item.date, item.description, link)
        end
      end
    end
  end
end
