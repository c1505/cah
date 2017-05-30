class RoundsController < ApplicationController
  def update

    @round = Round.find(params[:id])
    @game = @round.game
    # FIXME should just pass the card id with the form
    @white_card = WhiteCard.find(params[:cardId])
    @round.white_cards << @white_card
    
    # current_user.white_cards.delete(@white_card)
    # current_user.white_cards << @game.white_cards.sample(1).first
    @round.save
    flash[:notice] = "Card submitted: #{@white_card.text}"
    redirect_to @game
  end

  def winner
    @round = Round.find(params[:id])
    @game = @round.game
    @black_card = @round.black_card
    @white_card = WhiteCard.find(params[:white_card])


    @black_card.white_card = @white_card #is there a point to this
    
    @game.deal(@round.white_cards)
    
    @black_card.user = @white_card.user #FIXME this is the winner, but a problem that there can only be one
    
    flash[:notice] = "The winner is: #{params[:white_card]}" if @black_card.save

    @round = @round.next_round(@black_card, @game)
  
    @game.rounds << @round

    @game.save
    redirect_to @game
  end



end
