class Game < ApplicationRecord
  has_and_belongs_to_many :users
  has_many :rounds
  has_many :black_decks
  has_many :black_cards
  has_many :white_decks
  has_many :white_cards

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
      round.black_card = black_cards[rand(black_cards.count)]

      round.save
      self.rounds << round
    end
  end

  def deal(played_white_cards=[])
      played_white_cards.each do |played_card|
        user = played_card.user
        user.white_cards.delete(played_card)
        new_card = self.white_cards.sample(1).first
        user.white_cards << new_card
        self.white_cards.delete(new_card)
      end
  end
  
  def build_deck(sfw, count)
    json = File.read("cah.json")
    parsed = JSON.parse(json)

    black_cards = parsed["blackCards"]

    black_cards.each do |card|
      BlackCard.create(text: card["text"], blanks: card["pick"], game_id: self.id)
    end


    sfw_json = File.read("sfw_whiteCards.json")
    sfw_white_cards = JSON.parse(sfw_json)

    sfw_white_cards = sfw_white_cards["whiteCards"]

    sfw_white_cards.take(count).each do |card|
      WhiteCard.create(text: card, sfw: true, game_id: self.id)
    end

    unless sfw == "1"
      nsfw_json = File.read("nsfw_whiteCards.json")
      nsfw_white_cards = JSON.parse(nsfw_json)
  
      nsfw_white_cards = nsfw_white_cards["whiteCards"]
  
      nsfw_white_cards.take(count).each do |card|
        WhiteCard.create(text: card, sfw: false, game_id: self.id)
      end
    end
  end


end
