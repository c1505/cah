require 'rails_helper'

RSpec.describe Game, type: :model do

  describe "#deal" do

    it "removes submitted card from user, gives new card, and removes dealt card from game" do #FIXME maybe too many things for this test

      game = FactoryGirl.create(:game)
      game.build_deck("1", 8)
      

      player_white_cards = game.white_cards.sample(7)
      player = FactoryGirl.create(:user, white_cards: player_white_cards)

      game.white_cards = game.white_cards - player_white_cards
      played_card = player.white_cards.first
      game.deal([played_card])

      expect(game.white_cards).to eq []
      expect(player.white_cards).to_not include(played_card)
    end

    it "one user can have 2 active games"
    #  could not implement and instead clear the user.white_cards association
    # for each user at the start of the game

  end
  
  describe "#seed_cards" do
    it "new white cards are created for each game" do
      game_1 = FactoryGirl.create(:game)
      game_1.build_deck("1",20)
      game_2 = FactoryGirl.create(:game)
      game_2.build_deck("1",20)
      expect(game_1.white_cards).to_not include(game_2.white_cards.first)
    end
    
    it "new black cards are created for each game" do
      game_1 = FactoryGirl.create(:game)
      game_1.build_deck("1", 20)
      game_2 = FactoryGirl.create(:game)
      game_2.build_deck("1", 20)
      expect(game_1.black_cards).to_not include(game_2.black_cards.first)
    end
  end
  it "different users can have same white_cards if not in the same game" do

    sfw_json = File.read("sfw_whiteCards.json")
    sfw_white_cards = JSON.parse(sfw_json)

    sfw_white_cards = sfw_white_cards["whiteCards"]

    sfw_white_cards.sample(7).each do |card|
      WhiteCard.create(text: card, sfw: true)
    end

    user_1 = FactoryGirl.create(:user, name: "player1", email: "user1@email.com")
    user_2 = FactoryGirl.create(:user, name: "player2", email: "user2@email.com")

    user_1.white_cards = WhiteCard.all
    user_1.save
    user_2.white_cards = WhiteCard.all
    user_2.save

    expect(user_1.white_cards).to eq user_2.white_cards
  end

  # it "complete game setup" do
    #   dealer = FactoryGirl.create(:user)
    #   player = FactoryGirl.create(:user, name: "player", email: "user2@email.com")
    #   game = Game.new(name: "deal")
    #   game.users = [dealer, player]
    #   game.build_deck("1")
    #   game.save
    #   game.start(dealer)
    #   initial = player.white_cards
    #   round = game.rounds.last

    #   played_card = player.white_cards.first
    #   round.play_card(player, played_card)

    #   round.select_winner(round.white_cards.first)
    #   game.deal(round.white_cards)

    #   expect(game.white_cards).to_not include(played_card)
    #   expect(player.white_cards).to_not include(played_card)

    # end


  # def seed_cards
  #   json = File.read("cah.json")
  #   parsed = JSON.parse(json)

  #   black_cards = parsed["blackCards"]


  #   black_cards.sample(5).each do |card|
  #     BlackCard.create(text: card["text"], blanks: card["pick"])
  #   end


  #   sfw_json = File.read("sfw_whiteCards.json")
  #   sfw_white_cards = JSON.parse(sfw_json)

  #   sfw_white_cards = sfw_white_cards["whiteCards"]

  #   sfw_white_cards.sample(30).each do |card|
  #     WhiteCard.create(text: card, sfw: true)
  #   end


  #   nsfw_json = File.read("nsfw_whiteCards.json")
  #   nsfw_white_cards = JSON.parse(nsfw_json)

  #   nsfw_white_cards = nsfw_white_cards["whiteCards"]

  #   nsfw_white_cards.sample(10).each do |card|
  #     WhiteCard.create(text: card, sfw: false)
  #   end
  # end
end
