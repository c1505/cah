class Game < ApplicationRecord
  has_and_belongs_to_many :users
  has_many :rounds
  
  def started?
    !rounds.blank?
  end
  
  def start
    unless started?
      round = Round.create(number: 1)
      self.rounds << round
    end
  end
    
end
