class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy

  before_save :prepare_save

  def prepare_save
    # URLのまま入力されている場合は、IDを抽出
    if self.youtube_video_id =~ /^https:\/\/www.youtube.com\/watch\?v=(.+)$/
      self.youtube_video_id = $1
    end

    true
  end

end
