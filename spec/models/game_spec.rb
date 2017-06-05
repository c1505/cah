require 'rails_helper'

RSpec.describe Game, type: :model do
  before :each do
    seed_cards
  end
  describe "#deal" do
    it "removes submitted card from user and gives new card" do
      dealer = FactoryGirl.create(:user)
      player = FactoryGirl.create(:user, name: "player", email: "user2@email.com")
      game = Game.new(name: "deal")
      game.users = [dealer, player]
      game.build_deck("1")
      game.save
      game.start(dealer)
      initial = player.white_cards
      round = game.rounds.last

      played_card = player.white_cards.first
      round.play_card(player, played_card)
      
      round.select_winner(round.white_cards.first)
      game.deal(round.white_cards)

      
      expect(player.white_cards).to_not include(played_card)

    end
  end
    
  
  def seed_cards
    json = File.read("cah.json")
    parsed = JSON.parse(json)

    black_cards = parsed["blackCards"]


    black_cards.sample(5).each do |card|
      BlackCard.create(text: card["text"], blanks: card["pick"])
    end


    sfw_json = File.read("sfw_whiteCards.json")
    sfw_white_cards = JSON.parse(sfw_json)

    sfw_white_cards = sfw_white_cards["whiteCards"]

    sfw_white_cards.sample(30).each do |card|
      WhiteCard.create(text: card, sfw: true)
    end


    nsfw_json = File.read("nsfw_whiteCards.json")
    nsfw_white_cards = JSON.parse(nsfw_json)

    nsfw_white_cards = nsfw_white_cards["whiteCards"]

    nsfw_white_cards.sample(10).each do |card|
      WhiteCard.create(text: card, sfw: false)
    end
  end
end
