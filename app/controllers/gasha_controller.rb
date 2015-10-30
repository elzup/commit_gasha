class GashaController < ApplicationController
  def index
  end

  def turn
    @user.turn_card
    redirect_to '/gasha/res'
  end

  def turn10
  end

  def res
    @cards = [@user.last_card]
  end

  def res10
    # TODO: recent 10 card
    render
  end
end
