class WhiteCard < ApplicationRecord
  has_and_belongs_to_many :rounds
  belongs_to :user, optional: true
  belongs_to :black_card, optional: true
  belongs_to :game
  
  scope :sfw, -> { where(sfw: true) }
  
  scope :nsfw, -> { where(sfw: false) }
  
end
