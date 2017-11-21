class AddImageToUserPets < ActiveRecord::Migration[5.1]
  def change
    add_column :user_pets, :image, :string, after: :one_phrase
  end
end
