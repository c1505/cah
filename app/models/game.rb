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

  def deal(played_white_cards)
    played_white_cards.each do |played_card|
      user = played_card.user
      user.white_cards.delete(played_card)
      new_card = self.white_cards.sample(1).first
      user.white_cards << new_card
      self.white_cards.delete(new_card)
    end
  end

  def build_deck(input)
    if input == "1"
      self.white_cards = WhiteCard.sfw
    else
      self.white_cards = WhiteCard.all
    end
  end

end
