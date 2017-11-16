class CreateUserInfos < ActiveRecord::Migration[5.1]
  def change
    create_table :user_infos do |t|
      t.references :user, foreign_key: true, null: false, index: true
      t.string :nickname, null: false
      t.string :hash_id, null: false
      t.integer :sex
      t.boolean :has_icon
      t.integer :breed_history
      t.string :one_phrase
      t.string :youtube_channel_id
      t.string :twitter_id
      t.string :blog_url

      t.timestamps
    end

    add_index  :user_infos, [:hash_id], unique: true
  end
end
