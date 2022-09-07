class ApplicationController < ActionController::Base
  helper_method :current_user

  def redirect_with_alert
    redirect_to root_path, alert: "Данная страница недоступна для Вас"
  end

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end
end
