class HomeController < ApplicationController
  GITHUB_CONFIG = Rails.application.secrets.github_app
  def index
    token = session[:github_token]
    @user = User.login_user(token)
  end
end
