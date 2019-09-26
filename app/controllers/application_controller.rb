class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :authenticate_user!

  helper_method :current_user,
                :logged_in?

  private

  def authenticate_user!
    cookies[:original_path] = request.fullpath
    
    unless current_user
      redirect_to root_path, alert: 'Вы Гуру? Подтвердите свою почту и пароль, пожалуйста'
    end
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def logged_in?
    current_user.present?
  end
end
