class CreateUserInfos < ActiveRecord::Migration[5.1]
  def change
    create_table :user_infos do |t|
      t.references :user, foreign_key: true, null: false, index: true
      t.string :nickname, null: false
      t.integer :sex
      t.string :icon
      t.integer :breed_history
      t.string :pet_name
      t.string :pet_type
      t.string :pet_sex
      t.string :youtube_channel_id
      t.string :twitter_id
      t.string :blog_url

      t.timestamps
    end
  end
end
