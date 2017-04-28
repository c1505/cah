class Round < ApplicationRecord
  belongs_to :host, class_name: 'User', foreign_key: 'user_id'
  belongs_to :black_card
  has_and_belongs_to_many :white_cards
end
