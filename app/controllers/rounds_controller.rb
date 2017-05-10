class RoundsController < ApplicationController
  def update

    @round = Round.find(params[:id])
    @game = @round.game
    # FIXME should just pass the card id with the form
    @white_card = WhiteCard.find(params[:cardId])
    @white_card.user = current_user
    @white_card.save
    @round.white_cards << @white_card
    @round.save
    flash[:success] = "Card submitted: #{@white_card.text}"
    redirect_to @game
  end

  def winner
    # winner is the user
    # associate the white card to the black card
    # round.winner looks at the black card and figures out what white card belongs to it

    @round = Round.find(params[:id])
    @game = @round.game
    @black_card = @round.black_card
    @white_card = WhiteCard.find_by(text: params[:white_card])
    @black_card.white_card = @white_card

    @black_card.user = @white_card.user #FIXME do I really need this or should i reach through the assocation
    flash[:success] = "The winner is: #{params[:white_card]}" if @black_card.save


    round_number = @round.number + 1 #FIXME not sure if I need a round number
    @round = Round.new(number: round_number)
    @round.host = @black_card.user #FIXME might prefer that this just rotates
    black_cards = BlackCard.all
    @round.black_card = black_cards[rand(black_cards.count)]
    @game.rounds << @round

    @game.save
    redirect_to @game



  end

  private
  def next_round
    round_number = @round.number + 1 #FIXME not sure if I need a round number
    @round = Round.new(number: round_number)
    @round.host = @black_card.user #FIXME might prefer that this just rotates
    black_cards = BlackCard.all
    @round.black_card = black_cards[rand(black_cards.count)]
    @game.rounds << @round
  end


end
