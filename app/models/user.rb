class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         # FIXME: リリース前にテストする。
         # :confirmable, :lockable

  # before_save :prepare_save # This callback doesn't validate
  after_create  :prepare_create

  # 新規作成の場合
  def prepare_create
    user_info = UserInfo.new

    user_info.user_id = self.id
    user_info.nickname = self.email.split('@')[0]

    user_info.save
  end
end
