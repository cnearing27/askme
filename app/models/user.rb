class User < ApplicationRecord
  include Gravtastic

  has_secure_password
  has_many :questions, dependent: :delete_all

  before_validation :downcase_nickname

  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :nickname, presence: true, uniqueness: true, length: { maximum: 40 }, format: { with: /\A\w+\z/ }
  validates :header_color, format: { with: /\A#\w{6}\z/ }

  gravtastic(secure: true, filetype: :png, size: 100, default: "identicon")

  def to_param
    nickname
  end

  private

  def downcase_nickname
    nickname&.downcase!
  end
end
