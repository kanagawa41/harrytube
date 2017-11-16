class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         # FIXME: リリース前にテストする。
         # :confirmable, :lockable

  # before_save :prepare_save # This callback doesn't validate
  after_create  :prepare_create

  has_one :user_info, dependent: :destroy
  has_many :user_pets, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  # 新規作成の場合
  def prepare_create
    require 'digest/md5'

    user_info = UserInfo.new

    user_info.id = self.id
    user_info.user_id = self.id
    # メールアドレスより挿入
    user_info.nickname = self.email.split('@')[0]

    # ea703e7aa1efda0064eaa507d9e8ab7eのうち
    # efda0064eaが取得できる
    user_info.hash_id = Digest::MD5.new.update(self.id.to_s).to_s[10,10]

    user_info.save
  end
end
