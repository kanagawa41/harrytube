class Post < ApplicationRecord
  include Regexps

  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  validates :title, presence: true
  validates :description, presence: true
  validates :youtube_video_id, presence: true
  validate :youtube_video_id_format

  before_save :prepare_save

  # youtubeのidの形式チェック
  def youtube_video_id_format
    target = self.youtube_video_id
    # URLのまま入力されている場合は、IDを抽出
    target.match(REG_YOUTUBE_URL) do |md|
      target = md[1]
    end

    unless target =~ /^\w+$/
      errors.add(:youtube_video_id, I18n.t("errors.messages.invalid"))
    end
  end

  # save前処理
  def prepare_save
    # URLのまま入力されている場合は、IDを抽出
    self.youtube_video_id.match(REG_YOUTUBE_URL) do |md|
      self.youtube_video_id = md[1]
    end

    true
  end

end
