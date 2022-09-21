class HashtagsController < ApplicationController
  before_action :set_hashtag, only: %i[ show ]

  def index
    @hashtags = Hashtag.all
  end

  def create
    @hashtag = Hashtag.new(hashtag_params)
    @hashtag.save
  end

  private

  def set_hashtag
    @hashtag = Hashtag.find_by!(body: "##{params[:tag]}")
  end

  def hashtag_params
    params.require(:hashtag).permit(:body)
  end
end
