class HarriesController < ApplicationController
  layout "blog_home1"

  before_action :init_setting

  def index
    @posts = HarriesService.index
    # FIXME: キチンとしたロジックに基づき取得する。
    @recommend_post = Post.order(created_at: :desc).limit(4)
    # FIXME: キチンとしたロジックに基づき取得する。
    @ranking_post = Post.order(created_at: :desc).limit(4)
  end

  def information
    render :layout => 'full_width'
  end

  def feature
    # TODO: 特集の出力処理を作成する。
  end

  def ranking
    # FIXME: ランキングのデータを取得する
    @ranking_post = Post.order(created_at: :desc).page(@page)
  end

  def tag
    # TODO: タグの出力処理を作成する。
  end

  private

  def init_setting
    @title = 'トップ'
  end

end