class RemoveHasIconFromUserInfo < ActiveRecord::Migration[5.1]
  def change
    remove_column :user_infos, :has_icon, :boolean
  end
end
