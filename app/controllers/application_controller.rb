class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :set_variables

  # 別だしで宣言できないか検討する
  ##########################################

  # 本人が操作する必要がある
  class NeedBeOriginal < ActionController::ActionControllerError; end

  rescue_from NeedBeOriginal, with: :rescue403

  def rescue403(e)
    @exception = e
    redirect_to controller: 'devise/sessions', action: 'new', status: 403
  end

  ##########################################

  # moduleでも使用できるように詰め直す
  def set_variables
    $logger = Rails.logger
    $current_user = current_user
  end

  # page パラメータを手動で設定された場合の対策
  def normalize_page
    if params[:page].present?
      page = params[:page].to_i
      @page = (page <= 1 || page > Kaminari.config.max_pages.to_i) ? nil : page
    end
  end

  # Ajaxで通信を行っているか
  def request_ajax?
    # FIXME: 本番ではどのように表示されるか確認する
    unless request.xhr?
      raise AbstractController::ActionNotFound
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

  # 本人か？
  def origin_person?(user_info_id)
    # 本人が開いた場合
    @is_org_user = user_signed_in? && user_info_id == current_user.id
  end

  # ログインしているかつ、本人か？
  def origin_signed_in?(user_info_id)
    raise NeedBeOriginal unless signed_in?

    origin_person? user_info_id

    raise NeedBeOriginal unless @is_org_user
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
