class User < ApplicationRecord
  has_secure_password

  validates :email, presence: true, uniqueness: true

  before_save :downcase_nickname

  def downcase_nickname
    nickname.downcase!
  end
end
