class RemoveHasIconFromUserPet < ActiveRecord::Migration[5.1]
  def change
    remove_column :user_pets, :has_icon, :boolean
  end
end
