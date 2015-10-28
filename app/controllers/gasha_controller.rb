class GashaController < ApplicationController
  def index
    @user = User.login_user(session[:github_token])
    if @user.nil?
      redirect_to '/'
    end
    if @user.can_turn_card?
      @card = @user.turn_card
    end
  end

  def import
    @user = User.login_user(session[:github_token])
    @num = @user.import_commits
  end
end
