class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :auth_user

  def auth_user
    @user = User.login_user(session[:github_token])
    if @user.nil?
      redirect_to '/'
    end
  end
end
