class SearchKeyword < ApplicationRecord
  belongs_to :user
  has_many :tv_programs, dependent: :nullify
  validates :keyword, presence: true
  scope :default_order, -> { order(id: :desc) }

  NOTIFICATION_ITEM_MAX = 20
  NOTIFICATION_ITEMS_PER_MESSAGE = 5

  def search_and_notify
    items = TvProgram::Collector.search(keyword)
    urls = TvProgram.where(url: items.map(&:link)).pluck(:url)
    items = items.reject { |item| urls.member?(item.link) }
    items = items.take(NOTIFICATION_ITEM_MAX)
    return if items.blank?
    items.each_slice(NOTIFICATION_ITEMS_PER_MESSAGE).each do |subitems|
      item_messages = subitems.map do |item|
        <<~EOS
        ■ #{item.title}
        #{item.description}
        #{item.link}
        EOS
      end
      message = %(「#{keyword}」に関連する番組が見つかりました！\n\n#{item_messages.join("\n")})
      if line_notification_target = user.line_notification_targets.first
        Line::Notify.new(line_notification_target.token).send(message)
      end
      create_tv_programs(subitems)
    end
  end

  def create_tv_programs(items)
    TvProgram.transaction do
      items.each do |item|
        tv_programs.create!(
          user: user,
          keyword: keyword,
          url: item.link,
          start_at: item.date,
          title: item.title,
          description: item.description
        )
      end
    end
  end
end
