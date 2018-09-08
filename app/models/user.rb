class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :rememberable,
         :omniauthable, omniauth_providers: %i(line line_notify)
  has_many :line_notification_targets, dependent: :destroy
  has_many :search_keywords, dependent: :destroy
  has_many :tv_programs, dependent: :destroy

  class << self
    def find_or_create_by_auth_hash!(hash)
      Rails.logger.info hash.to_h
      user = User.find_by(uid: hash['uid'], provider: hash['provider']) || User.create do |u|
        u.uid = hash['uid']
        u.provider = hash['provider']
        u.name = hash['info']['name']
        u.image = hash['info']['image']
        u.description = hash['info']['description'] || ''
        u.token = hash['credentials']['token']
        u.secret = hash['credentials']['secret']
        u.auth_hash = hash
      end
      Rails.logger.info user.errors.full_messages.to_s
      user
    end
  end
end
