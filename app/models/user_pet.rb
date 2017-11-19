class UserPet < ApplicationRecord
  belongs_to :user

  enum pet_sex: [:unknown, :male, :female]

end
