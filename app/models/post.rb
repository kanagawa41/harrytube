class Post < ApplicationRecord
  include Regexps

  is_impressionable # PVカウント
  is_impressionable :counter_cache => true

  acts_as_taggable # Alias for acts_as_taggable_on :tags

  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  validates :title, presence: true
  validates :description, presence: true
  validates :youtube_video_id, presence: true, format: { with:  REG_EN_NU_H }

  # オススメを返却する
  def self.find_recommend_posts_for_sidebar(post)
    post.find_related_tags
  end

  # ランキングを取得する
  def self.find_ranking_posts_for_sidebar(limit)
    tmp_orm = Post.order(impressions_count: :desc)

    if limit.present?
      tmp_orm.limit(limit)
    else
      tmp_orm
    end
  end


  # validate :youtube_video_id_format
  #
  # before_save :prepare_save
  #
  # youtubeのidの形式チェック
  # FIXME: 記録のために残している。不要になったら削除
  # def youtube_video_id_format
  #   target = self.youtube_video_id
  #   # URLのまま入力されている場合は、IDを抽出
  #   target.match(REG_YOUTUBE_URL) do |md|
  #     target = md[1]
  #   end

  #   unless target =~ /^\w+$/
  #     errors.add(:youtube_video_id, I18n.t("errors.messages.invalid"))
  #   end
  # end

  # save前処理
  # FIXME: 記録のために残している。不要になったら削除
  # def prepare_save
  #   # URLのまま入力されている場合は、IDを抽出
  #   self.youtube_video_id.match(REG_YOUTUBE_URL) do |md|
  #     self.youtube_video_id = md[1]
  #   end

  #   true
  # end

end
