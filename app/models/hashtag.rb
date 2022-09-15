class Hashtag < ApplicationRecord
  has_and_belongs_to_many :questions

  before_validation :downcase_body

  validates :body, presence: true, uniqueness: true, format: { with: /\A#[\wа-я\d]+\z/ }

  def to_param
    body
  end
  
  private

  def downcase_body
    body&.downcase!
  end
end
