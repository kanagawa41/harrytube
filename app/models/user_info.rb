class UserInfo < ApplicationRecord
  include Regexps

  belongs_to :user

  enum sex: [:unknown, :male, :female]

  # validates :nickname
  validates :breed_history, numericality: { allow_blank: true }
  validates :youtube_channel_id, format: { with: REG_EN_NU_H, allow_blank: true }
  validates :twitter_id, format: { with: REG_EN_NU_H, allow_blank: true }
  validates :blog_url, format: { with: REG_URL, allow_blank: true }

  # ハッシュよりidを取得する
  def self.find_id_by_hash(hash_id)
    UserInfo.where(hash_id: hash_id).first[:user_id]
  end
end
