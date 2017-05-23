class WhiteDeck < ApplicationRecord
  belongs_to :white_card
  belongs_to :game
end