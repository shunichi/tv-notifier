class SearchKeyword < ApplicationRecord
  belongs_to :user
  validates :keyword, presence: true

  NOTIFICATION_ITEM_MAX = 10

  def search_and_notify
    items = TvProgram.search(keyword)
    return if items.blank?
    item_messages = items.take(NOTIFICATION_ITEM_MAX).map do |item|
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
  end
end
