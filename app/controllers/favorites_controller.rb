class FavoritesController < ApplicationController
  before_action :set_favorite, only: [:show, :edit, :update]

  # GET /favorites
  # GET /favorites.json
  def index
    request_ajax?

    @favorites = Favorite.all

    render json: {"result" => @favorites}, status: 200
  end

  # POST /favorites
  # POST /favorites.json
  def create
    request_ajax?
    signed_in?

    @favorite = Favorite.new(favorite_params)
    @favorite.user_id = current_user.id

    if @favorite.save
      render json: {result:
        {
          favorite_count: Favorite.where(post_id: @favorite.post_id).count,
        }
      }, status: 200
    else
      render json: @favorite.errors, status: :unprocessable_entity
    end
  end

  # DELETE /favorites/1
  # DELETE /favorites/1.json
  def destroy
    request_ajax?
    signed_in?

    # FIXME: 取得できない場合にその旨のエラーを通知する
    @favorite = Favorite.find_by(post_id: favorite_params[:post_id], user_id: current_user.id)

    @favorite.destroy

    render json: {result:
      {
        favorite_count: Favorite.where(post_id: @favorite.post_id).count,
      }
    }, status: 200
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_favorite
      @favorite = Favorite.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def favorite_params
      params.require(:favorite).permit(:user_id, :post_id)
    end
end
