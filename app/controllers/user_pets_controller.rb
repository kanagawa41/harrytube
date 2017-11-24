class UserPetsController < ApplicationController
  layout "blog_home1"

  before_action :set_user_pet, only: [:show, :edit, :update, :destroy]

  # GET /user_pets
  def index
    @user_pets = UserPet.order(created_at: :desc).page(@page)
  end

  # GET /user_pets/user/ea703e7aa1
  def user_index
    user_id = UserInfo.find_id_by_hash(params[:hash_id])
    origin_person? user_id

    @user_pets = UserPet.where(user_id: user_id).all
    @is_ok_regist = UserPet.has_pets_space? user_id
  end

  # GET /user_pets/1
  def show
    origin_person? @user_pet.user.id
  end

  # GET /user_pets/new
  def new
    return unless signed_in?

    @user_pet = UserPet.new
  end

  # GET /user_pets/1/edit
  def edit
    return unless origin_signed_in? @user_pet.user.id
  end

  # POST /user_pets
  def create
    return unless signed_in?
    @user_pet = UserPet.new(user_pet_params)
    @user_pet.user_id = current_user.id

    unless UserPet.has_pets_space? @user_pet.user_id
      @user_pet.errors[:base] << "ペットは10匹までしか登録できません。"
      render :new
      return
    end

    if @user_pet.save
      redirect_to @user_pet, notice: 'ハリネズミを登録しました。'
    else
      render :new
    end
  end

  # PATCH/PUT /user_pets/1
  def update
    origin_signed_in?(@user_pet.user.id)

    if @user_pet.update(user_pet_params)
      redirect_to @user_pet, notice: 'ハリネズミの情報を更新しました。'
    else
      render :edit
    end
  end

  # DELETE /user_pets/1
  def destroy
    origin_signed_in?(@user_pet.user.id)

    @user_pet.destroy
    # FIXME: 次に表示するページが正しく表示されない
    redirect_to user_pets_user_infos_url(hash_id: @user_pet.user.user_info.hash_id), notice: 'ハリネズミの情報を削除しました。'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_pet
      @user_pet = UserPet.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def user_pet_params
      tmp_params = params.require(:user_pet).permit(:user_id, :pet_name, :pet_birthday, :pet_type, :pet_sex, :one_phrase, :image)
      tmp_params[:pet_sex] = tmp_params[:pet_sex].to_i if tmp_params[:pet_sex].present?

      tmp_params
    end
end
