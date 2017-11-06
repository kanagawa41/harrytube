class SamplesController < ApplicationController
  layout "to_c"
  before_action :init_setting, :normalize_page

  def index
  end


  def services
  end


  def contact
  end


  def sidebar
  end


  def about
  end


  def blog_home_1
  end


  def blog_home_2
  end


  def blog_post
  end


  def faq
  end


  def full_width
  end


  def portfolio_1_col
  end


  def portfolio_2_col
  end


  def portfolio_3_col
  end


  def portfolio_4_col
  end


  def portfolio_item
  end


  def pricing
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