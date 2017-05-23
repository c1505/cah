class Game < ApplicationRecord
  has_and_belongs_to_many :users
  has_many :rounds
  has_many :black_decks
  has_many :black_cards, :through => :black_decks

  def started?
    !rounds.blank?
  end

  def start(current_user)
    unless started?
      round = Round.new(number: 1)
      round.host = current_user
      
      black_cards = BlackCard.all
      round.black_card = black_cards[rand(black_cards.count)]
      
      round.save
      self.rounds << round
    end
  end

end
