class CreatePosts < ActiveRecord::Migration[5.1]
  def change
    create_table :posts do |t|
      t.references :user, foreign_key: true, null: false, index: true
      t.string :title, null: false
      t.text :description, null: false
      t.string :youtube_video_id, null: false
      t.string :tags

      t.timestamps
    end
  end
end
