class RoundsController < ApplicationController
  def update

    @round = Round.find(params[:id])
    @game = @round.game
    @white_card = WhiteCard.find(params[:cardId])
    @round.white_cards << @white_card
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
    winner = @white_card.user
    @black_card.user = winner #FIXME this is the winner, but a problem that there can only be one per black card
    flash[:notice] = "The winner is: #{params[:white_card]}" if @black_card.save

    @round = @round.next_round(@black_card, @game)

    @game.rounds << @round

    @game.save
    redirect_to @game
  end



end
