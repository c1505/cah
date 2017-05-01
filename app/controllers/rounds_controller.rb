class RoundsController < ApplicationController
  def update
    # round.white_cards << roundparams
    # round.save
    # current_user.active_cards -= roundparams

    # save card to round
    # remove card from user inventory
    #

    
    @round = Round.find(params[:id])
    @game = @round.game
    # FIXME should just pass the card id with the form
    @white_card = WhiteCard.find_by(text: params[:white_card])
    @white_card.user = current_user
    @white_card.rounds << @round
    @white_card.save
    @round.white_cards << @white_card
    @round.save
    flash[:success] = "Card submitted: #{params[:white_card]}"
    redirect_to @game
  end



end
