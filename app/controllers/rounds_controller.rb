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
    # FIXME whitecard user is nil because i removed it when I sent in the card
    @black_card.white_card = @white_card
    deal(@round.white_cards, @game)
    @black_card.user = @white_card.user #FIXME this is the winner, but a problem that there can only be one
    flash[:notice] = "The winner is: #{params[:white_card]}" if @black_card.save


    round_number = @round.number + 1 #FIXME not sure if I need a round number
    @round = Round.new(number: round_number)
    @round.host = @black_card.user #FIXME might prefer that this just rotates
    black_cards = BlackCard.all
    @round.black_card = black_cards.sample(1).first
  
    @game.rounds << @round

    @game.save
    redirect_to @game
  end
  
  private
  def deal(white_cards, game)
    white_cards.each do |card|
      user = card.user
      game.white_cards.delete(card)
      user.white_cards.delete(card)
      user.white_cards << game.white_cards.sample(1).first
    end
  end



end
