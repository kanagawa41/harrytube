class UserInfosController < ApplicationController
  layout "blog_home1"

  before_action :set_user_info, only: [:show, :edit, :update]

  # GET /user_infos
  # GET /user_infos.json
  def index
    @user_infos = UserInfo.all
  end

  # GET /user_infos/1
  # GET /user_infos/1.json
  def show
    origin_person? @user_info.id
  end

  # GET /user_infos/1/edit
  def edit
    origin_signed_in?(@user_info.id)
  end

  # PATCH/PUT /user_infos/1
  # PATCH/PUT /user_infos/1.json
  def update
    origin_signed_in?(@user_info.id)
    if @user_info.update(user_info_params)
      redirect_to user_info_path(@user_info.hash_id), notice: 'ユーザ情報を更新しました。'
    else
      render :edit
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_info
      @user_info = UserInfo.find_by(hash_id: params[:hash_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_info_params
      tmp_params = params.require(:user_info).permit(:user_id, :hash_id, :nickname, :sex, :has_icon, :breed_history, :one_phrase, :youtube_channel_id, :twitter_id, :blog_url, :image)
      tmp_params[:sex] = tmp_params[:sex].to_i if tmp_params[:sex].present?

      tmp_params
    end
end
