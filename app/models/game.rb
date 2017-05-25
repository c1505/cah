class Game < ApplicationRecord
  has_and_belongs_to_many :users
  has_many :rounds
  has_many :black_decks
  has_many :black_cards, :through => :black_decks
  has_many :white_decks
  has_many :white_cards, :through => :white_decks

  def started?
    !rounds.blank?
  end

  def start(current_user)
    unless started?
      round = Round.new(number: 1)
      round.host = current_user
      
      self.users.each do |user|
        user.white_cards = []
        hand = white_cards.sample(7)
        user.white_cards = hand
        user.save
        white_cards.delete(hand)
      end
      black_cards = BlackCard.all
      round.black_card = black_cards[rand(black_cards.count)]
      
      round.save
      self.rounds << round
    end
  end

end
