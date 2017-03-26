class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def authenticate_user
    if current_user.nil?
      redirect_to new_user_session_url
    end
  end
end
