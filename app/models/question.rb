class Question < ApplicationRecord
  has_many :hashtag_questions, dependent: :destroy
  has_many :hashtags, through: :hashtag_questions

  belongs_to :user
  belongs_to :author, class_name: "User", optional: true

  validates :body, presence: true, length: { maximum: 280 }

  after_save_commit :update_hashtags, on: %i[create update]
#  after_save_commit :clear_hashtags, on: %i[update]

  private

  def update_hashtags
    self.hashtags =
      "#{body} #{answer}".downcase.scan(Hashtag::REGEXP).uniq.
      map { |tag| Hashtag.find_or_create_by(body: tag) }
  end

#  def clear_hashtags
#    Hashtag.all.each do |tag|
#      tag.destroy if tag.questions.empty?
#    end
#  end
end
