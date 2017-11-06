class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         # FIXME: リリース前にテストする。
         # :confirmable, :lockable

  before_save :prepare_save # This callback doesn't validate

  def prepare_save
    unless self.username.present?
      self.username = self.email.split('@')[0]
    end

    self
  end
end
