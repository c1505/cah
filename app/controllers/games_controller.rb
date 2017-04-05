class GamesController < ApplicationController
  def new
    @game = Game.new
  end
  
  def index
  end
  
  def create
    game = Game.new(game_params)
    game.users << current_user
    if game.save
      redirect_to game
    else
      render new_game_path
    end
  end
  
  def show
    @game = Game.find(params[:id])
  end
  
  private
    def game_params
      params.require(:game).permit(:name)
    end
    
    def current_user
      current_user ||= Guest.create(name: "guest", email: rand.to_s + "@example.com")
    end
    
end