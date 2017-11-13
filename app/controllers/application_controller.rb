class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :set_logger

  def set_logger
    $logger = Rails.logger
  end

  # page パラメータを手動で設定された場合の対策
  def normalize_page
    if params[:page].present?
      page = params[:page].to_i
      @page = (page <= 1 || page > Kaminari.config.max_pages.to_i) ? nil : page
    end
  end

  # ログインチェック
  def signed_in?
    # ログインしていなかったら、ログインページに飛ばす
    unless user_signed_in?
      # ステータスコードを指定すると意図しない画面になる。
      redirect_to controller: 'devise/sessions', action: 'new'
      return false
    end
    true
  end

  # COMMENT: ActiveAdminではlocalをenを使用していたが、jaが見つかったので対処が不要になった
  # before_action :set_locale
  # アプリではJA、管理画面ではENを使用するため
  # def set_locale
  #   if request.path =~ /^\/admin/
  #     I18n.locale = :en
  #   else
  #     I18n.locale = :ja
  #   end
  # end
end
