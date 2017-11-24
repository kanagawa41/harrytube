class RemoveTagsFromPost < ActiveRecord::Migration[5.1]
  def change
    remove_column :posts, :tags, :string
  end
end
