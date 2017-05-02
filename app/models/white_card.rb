class WhiteCard < ApplicationRecord
  has_and_belongs_to_many :rounds
  belongs_to :user
  belongs :black_card
end
