class GashaController < ApplicationController
  def index
  end

  def turn
    @user.turn_card
    redirect_to '/gasha/res'
  end

  def turn10
    @user.turn_card10
    redirect_to '/gasha/res10'
  end

  def res
    @cards = @user.last_card
  end

  def res10
    @cards = @user.last_card10
    render :res
  end
end
