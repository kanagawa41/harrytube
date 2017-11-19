class UserPet < ApplicationRecord
  include Regexps

  belongs_to :user

  enum pet_sex: [:unknown, :male, :female]

end
