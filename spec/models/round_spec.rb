require 'rails_helper'

RSpec.describe Round, type: :model do
  describe "#play_card" do
    it "same white card can be used in different games by different players in different games" do
      # seed_cards
      #
      # black_card_1 = BlackCard.first
      # black_card_2 = BlackCard.first
      #
      # host = FactoryGirl.create(:user, name: "host", email: "host@email.com")
      # user_1 = FactoryGirl.create(:user, name: "player1", email: "user1@email.com")
      # user_2 = FactoryGirl.create(:user, name: "player2", email: "user2@email.com")
      #
      # white_card_text = WhiteCard.sfw.first.text
      # winning_white_card_1 = WhiteCard.sfw.first
      # winning_white_card_2 = WhiteCard.sfw.first
      #
      # game_1 = Game.new(name: "game1")
      # game_2 = Game.new(name: "game2")
      #
      # round_1 = Round.create(host: host, game: game_1, black_card: black_card_1)
      # round_2 = Round.create(host: host, game: game_2, black_card: black_card_2)
      # round_1.play_card(user_1, winning_white_card_1 )
      # round_2.play_card(user_2, winning_white_card_1 )
      #
      # expect(user_1.white_cards.first).to include white_card_text
      # expect(user_2.white_cards.first).to eq white_card_text

      # user 1 plays card 1 in game 1
      # user 2 plays card 1 in game 2


      # the failure would come when the card is dealt not when
      # it is submitted.
    end
  end
  describe "#select_winner" do #FIXME this reaches into too many methods for setup.  integration test or make it reach into fewer
    it "allows for winners of 2 separate games with the same black card text" do
      seed_cards

      black_card_text = BlackCard.first.text
      black_card_1 = BlackCard.first
      black_card_2 = BlackCard.first

      host = FactoryGirl.create(:user, name: "host", email: "host@email.com")
      user_1 = FactoryGirl.create(:user, name: "player1", email: "user1@email.com")
      user_2 = FactoryGirl.create(:user, name: "player2", email: "user2@email.com")

      white_card_text = WhiteCard.sfw.first.text
      winning_white_card_1 = WhiteCard.sfw.first
      winning_white_card_2 = WhiteCard.sfw.first

      winning_white_card_1.user = user_1
      winning_white_card_2.user = user_2

      game_1 = Game.new(name: "game1")
      game_2 = Game.new(name: "game2")
      round_1 = Round.create(host: host, game: game_1, black_card: black_card_1)

      round_2 = Round.create(host: host, game: game_2, black_card: black_card_2)
      round_1.play_card(user_1, winning_white_card_1 )
      round_2.play_card(user_2, winning_white_card_2 )

      winning_white_card_1.save
      winning_white_card_2.save
      # FIXME this test should fail because the white_cards are the same

      round_1.select_winner(winning_white_card_1)
      round_2.select_winner(winning_white_card_2)

      expect(round_1.black_card.text).to eq black_card_text
      expect(round_2.black_card.text).to eq black_card_text

      expect(round_1.winner).to eq user_1
      expect(round_2.winner).to eq user_2

      expect(round_1.winning_white_card.text).to eq white_card_text
      expect(round_2.winning_white_card.text).to eq white_card_text
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
