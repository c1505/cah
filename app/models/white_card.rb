class WhiteCard < ApplicationRecord
  has_and_belongs_to_many :rounds
  belongs_to :user
  belongs_to :black_card, optional: true
end
