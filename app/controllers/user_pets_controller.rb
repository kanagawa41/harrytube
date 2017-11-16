class UserPetsController < ApplicationController
  before_action :set_user_pet, only: [:show, :edit, :update, :destroy]

  # GET /user_pets
  def index
    @user_pets = UserPet.all
  end

  # GET /user_pets/1
  def show
  end

  # GET /user_pets/new
  def new
    @user_pet = UserPet.new
  end

  # GET /user_pets/1/edit
  def edit
  end

  # POST /user_pets
  def create
    @user_pet = UserPet.new(user_pet_params)

    if @user_pet.save
      redirect_to @user_pet, notice: 'User pet was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /user_pets/1
  def update
    if @user_pet.update(user_pet_params)
      redirect_to @user_pet, notice: 'User pet was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /user_pets/1
  def destroy
    @user_pet.destroy
    redirect_to user_pets_url, notice: 'User pet was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_pet
      @user_pet = UserPet.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def user_pet_params
      params.require(:user_pet).permit(:user_id, :has_icon, :pet_name, :pet_type, :pet_sex)
    end
end
