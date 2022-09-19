class Hashtag < ApplicationRecord
  REGEXP = /#[\wа-я\d]+/

  has_many :hashtag_questions, dependent: :destroy
  has_many :questions, through: :hashtag_questions

  before_validation :downcase_body

  validates :body, presence: true, uniqueness: true, format: { with: /\A#{REGEXP}\z/ }

  def to_param
    body
  end

  private

  def downcase_body
    body&.downcase!
  end
end
