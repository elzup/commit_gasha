class HomeController < ApplicationController
  GITHUB_CONFIG = Rails.application.secrets.github_app
  def index
    @user = User.login_user(session[:github_token])
    if @user.nil?
      render 'login'
    end
  end

  def login

  end
end
