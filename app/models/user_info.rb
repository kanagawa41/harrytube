class UserInfo < ApplicationRecord
  belongs_to :user

  # ハッシュよりidを取得する
  def self.find_id_by_hash(hash_id)
    UserInfo.where(hash_id: hash_id).first[:user_id]
  end
end
