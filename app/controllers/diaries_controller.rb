class DiariesController < ApplicationController
  layout "to_c"
  before_action :init_setting, :normalize_page

  def test1
  end

  def test2
  end

  private 

  def init_setting
    @title = 'トップ'
  end

  # page パラメータを手動で設定された場合の対策
  def normalize_page
    page = params[:page].to_i
    params[:page] = (page <= 1 || page > Kaminari.config.max_pages.to_i) ? nil : page
  end

end