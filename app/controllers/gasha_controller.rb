class GashaController < ApplicationController
  def index
    if @user.can_turn_card?
      @card = @user.turn_card
    end
  end
end
