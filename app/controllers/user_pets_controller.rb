class UserPetsController < ApplicationController
  layout "blog_home1"

  before_action :set_user_pet, only: [:show, :edit, :update, :destroy]

  # GET /user_pets
  def index
    @user_pets = UserPet.all
  end

  # GET /user_pets/user/ea703e7aa1
  def user_index
    user_id = UserInfo.find_id_by_hash(params[:hash_id])
    origin_person? user_id

    @user_pets = UserPet.where(user_id: user_id).all
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
    redirect_to user_pets_user_infos_url, notice: 'ハリネズミの情報を削除しました。'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_pet
      @user_pet = UserPet.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def user_pet_params
      tmp_params = params.require(:user_pet).permit(:user_id, :has_icon, :pet_name, :pet_birthday, :pet_type, :pet_sex, :one_phrase, :image)
      tmp_params[:pet_sex] = tmp_params[:pet_sex].to_i if tmp_params[:pet_sex].present?

      tmp_params
    end
end
