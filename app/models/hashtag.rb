class Hashtag < ApplicationRecord
  REGEXP = /#[\wа-я-]+/

  has_many :hashtag_questions, dependent: :destroy
  has_many :questions, through: :hashtag_questions

  before_validation :downcase_body

  validates :body, presence: true, format: { with: /\A#{REGEXP}\z/ }

  private

  def downcase_body
    body&.downcase!
  end
end
