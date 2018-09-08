class TvProgram < ApplicationRecord
  belongs_to :user
  belongs_to :search_keyword, optional: true
  validates :url, :start_at, :title, :description, presence: true
  scope :default_order, -> { order(start_at: :desc) }
end
