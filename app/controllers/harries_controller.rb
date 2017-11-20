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

  private

  def init_setting
    @title = 'トップ'
  end

end