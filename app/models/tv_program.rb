# frozen_string_literal: true

require 'rss'
require 'uri'
require 'pp'

class TvProgram
  def initialize()
  end

  Item = Struct.new(:title, :description, :link)

  class << self
    def search_url(keyword)
      "https://tv.so-net.ne.jp/rss/schedulesBySearch.action?condition.keyword=#{URI.escape(keyword)}&stationPlatformId=0"
    end

    def search(keyword)
      rss = RSS::Parser.parse(search_url(keyword))
      rss.items.map do |item|
        link = item.link.gsub(/\Ahttp:/, 'https:').gsub(/\?from=rss\z/, '')
        Item.new(item.title, item.description, link)
      end
    rescue RSS::MissingTagError
      []
    end
  end
end
