class HomeController < ApplicationController
  GITHUB_CONFIG = Rails.application.secrets.github_app
  skip_before_action :auth_user, only: [:index]

  def index
    @user = User.login_user(session[:github_token])
    @random_cards = Card.flat_sample(3)
    @cards = @user.cards.uniq
    if @user.nil?
      render 'login'
    end
  end

  def import
    @num = @user.import_commits
  end
end
