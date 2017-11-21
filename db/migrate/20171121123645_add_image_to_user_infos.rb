class AddImageToUserInfos < ActiveRecord::Migration[5.1]
  def change
    add_column :user_infos, :image, :string, after: :blog_url
  end
end
