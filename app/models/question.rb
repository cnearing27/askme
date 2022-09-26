class Question < ApplicationRecord
  has_many :hashtag_questions, dependent: :destroy
  has_many :hashtags, through: :hashtag_questions

  belongs_to :user
  belongs_to :author, class_name: "User", optional: true

  validates :body, presence: true, length: { maximum: 280 }

  after_save_commit :update_hashtags, on: %i[create update]

  private

  def update_hashtags
    self.hashtags =
      "#{body} #{answer}".downcase.scan(Hashtag::REGEXP).uniq.
        map { |tag| Hashtag.create_or_find_by!(body: tag) }
  end
end
