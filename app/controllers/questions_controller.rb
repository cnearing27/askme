class QuestionsController < ApplicationController
  before_action :ensure_current_user, only: %i[update destroy edit hide]
  before_action :set_question_for_current_user, only: %i[edit update destroy hide]

  def create
    question_params = params.require(:question).permit(:body, :user_id)

    @question = Question.new(question_params)
    @question.author = current_user

    if check_captcha(@question) && @question.save
      redirect_to user_path(@question.user), notice: "Новый вопрос создан"
    else
      flash.now[:alert] = "Текст вопроса слишком длинный"

      render :new
    end
  end

  def update
    question_params = params.require(:question).permit(:body, :answer)

    if @question.update(question_params)
      redirect_to user_path(@question.user), notice: "Вопрос обновлен"
    else
      flash.now[:alert] = "Текст вопроса слишком длинный"

      render :edit
    end
  end

  def destroy
    user = @question.user
    @question.destroy

    redirect_to user_path(user), notice: "Вопрос удален"
  end

  def show
    @question = Question.find(params[:id])
  end

  def index
    @questions = Question.order(created_at: :desc).last(10)
    @users = User.order(created_at: :desc).last(10)
    @question = Question.new
    @hashtags = Hashtag.all
  end

  def new
    if params[:user_id].present?
      user = User.find(params[:user_id])
      redirect_to(user_nickname: user)
      return
    end

    @user = User.find_by!(nickname: params[:user_nickname])
    @question = Question.new(user: @user)
  end

  def edit
  end

  def hide
    @question.update(hidden: true)

    redirect_to question_path(@question)
  end

  private

  def set_question_for_current_user
    @question = current_user.questions.find(params[:id])
  end

  def ensure_current_user
    redirect_with_alert unless current_user.present?
  end

  def check_captcha(model)
    current_user.present? || verify_recaptcha(model: model)
  end
end
