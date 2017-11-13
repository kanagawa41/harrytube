class HarriesController < ApplicationController
  layout "to_c"
  before_action :init_setting

  def index
    @posts = HarriesService.index
  end

  private

  def init_setting
    @title = 'トップ'
  end

end