require 'rails_helper'

RSpec.describe Game, type: :model do
  describe "#deal" do
    it "removes submitted card from user and gives new card" do
      user = FactoryGirl.create(:user)
      binding.pry
    end
    # setup
      # create game
      # add users
      # add cards
      # start game


    # remove a card from user
    # add new card to user
    # ensure user has 7 cards
    # ensure 6 of the cards are the same
    # ensure one of the cards is different
  end
end
