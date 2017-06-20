class RoundsController < ApplicationController
  def update
    @round = Round.find(params[:id])
    @game = @round.game
    @white_card = WhiteCard.find(params[:cardId])
    @round.play_card(current_user, @white_card)
    if @round.save
      flash[:notice] = "Card submitted: #{@white_card.text}"
      redirect_to @game
    else
      flash[:alert] = "error.  Please try again"
      render @game
    end

  end

  def winner
    @round = Round.find(params[:id])
    @game = @round.game
    @black_card = @round.black_card
    @winning_white_card = WhiteCard.find(params[:white_card])

    @game.deal(@round.white_cards)
    @round.select_winner(@winning_white_card)

    if @black_card.save && @game.save && @round.save
      @round = @round.next_round(@black_card, @game)
      @game.rounds << @round
      flash[:notice] = "The winner is: #{@winning_white_card.text}"
      redirect_to @game
    else
      render @game
    end

  end

end
