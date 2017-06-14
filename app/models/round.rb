class Round < ApplicationRecord
  belongs_to :host, class_name: 'User', foreign_key: 'user_id'
  belongs_to :winner, class_name: 'User', foreign_key: 'winner_id'
  belongs_to :winning_white_card, class_name: 'WhiteCard', foreign_key: 'winning_white_card_id'
  belongs_to :black_card
  has_and_belongs_to_many :white_cards
  belongs_to :game
  
  def next_round(black_card, game)
    round_number = self.number + 1 #FIXME not sure if I need a round number
    round = Round.new(number: round_number)
    round.host = winner #FIXME might prefer that this just rotates
    black_cards = BlackCard.all
    round.black_card = black_cards.sample(1).first
    round
  end
  
  def select_winner(white_card)
    self.winner = white_card.user
    self.winning_white_card = white_card
    self.save
  end
  
  def play_card(user, white_card)
    white_cards << white_card
  end
    
end
