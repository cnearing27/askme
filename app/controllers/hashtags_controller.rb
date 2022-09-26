class HashtagsController < ApplicationController
  before_action :set_hashtag, only: %i[ show ]

  def create
    @hashtag = Hashtag.new(hashtag_params)
    @hashtag.save
  end

  private

  def set_hashtag
    @hashtag = Hashtag.with_questions.find_by!(body: "##{params[:tag]}")
  end

  def hashtag_params
    params.require(:hashtag).permit(:body)
  end
end
