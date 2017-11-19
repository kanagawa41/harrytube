module Regexps
  extend ActiveSupport::Concern

  # youtubeのidを抽出
  REG_YOUTUBE_URL = /youtube.com\/watch\?v=(.+)$/
end