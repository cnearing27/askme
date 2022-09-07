class User < ApplicationRecord
  has_many :questions, dependent: :delete_all

  has_secure_password

  before_validation :downcase_nickname

  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :nickname, presence: true, uniqueness: true, length: { maximum: 40 }, format: { with: /\A[\w]+\z/ }

  private

  def downcase_nickname
    nickname.downcase!
  end
end
