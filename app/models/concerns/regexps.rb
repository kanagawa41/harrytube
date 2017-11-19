module Regexps
  extend ActiveSupport::Concern

  # 英数字のみ
  # ひらがな,カタカナ,漢字,半角英数（大小）,半角数字,全角数字
  REG_HI_KA_KN_EN_NU_HZ = /\A[ぁ-んァ-ヶーa-zA-Z0-9一-龠０-９]+\z/

  # 半角英数字のみ
  REG_EN_NU_H = /\A[0-9A-Za-z]+\z/

  # URL
  # http://bitarts.jp/blog/2015/09/14/rails_url_validate.html
  REG_URL = /\A#{URI::regexp(%w(http https))}\z/

  # youtubeのidを抽出
  # REG_YOUTUBE_URL = /youtube.com\/watch\?v=(.+)$/
end