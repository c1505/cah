class BlackCard < ApplicationRecord
  has_many :rounds
  has_one :white_card
  belongs_to :user, optional: true
end
