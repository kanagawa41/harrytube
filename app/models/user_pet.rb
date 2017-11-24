class UserPet < ApplicationRecord
  include Regexps

  belongs_to :user

  enum pet_sex: [:unknown, :male, :female]

  mount_uploader :image, ImageUploader

  # 保持できる最大数に達しているか？
  def self.has_pets_space?(user_id)
    UserPet.where(user_id: user_id).count < 10
  end

end
