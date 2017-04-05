class GamesController < ApplicationController
  def new
    @game = Game.new
  end
  
  def index
  end
  
  def create
    game = Game.new(game_params)
    binding.pry
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
    
end