class UserController < ApplicationController
  def index
    @user = User.login_user(session[:github_token])
  end
end
