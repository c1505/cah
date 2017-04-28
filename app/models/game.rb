class Game < ApplicationRecord
  has_and_belongs_to_many :users
  has_many :rounds

  def started?
    !rounds.blank?
  end

  def start(current_user)
    unless started?
      round = Round.new(number: 1)
      round.host = current_user
      round.save
      self.rounds << round
    end
  end

end
