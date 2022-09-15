class Question < ApplicationRecord
  has_and_belongs_to_many :hashtags
  
  belongs_to :user
  belongs_to :author, class_name: "User", optional: true

  validates :body, presence: true, length: { maximum: 280 }
end
