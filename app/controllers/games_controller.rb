class GamesController < ApplicationController
  def new
    @game = Game.new
  end
  
  def index
  end
  
  def join
    @game = Game.find(params[:id])
    create_guest unless current_user
    @game.users << current_user
    @game.save
    redirect_to @game
  end
  
  def create
    game = Game.new(game_params)
    game.users << create_guest
    if game.save
      redirect_to game
    else
      render new_game_path
    end
  end
  
  def show
    @game = Game.find(params[:id])
  end
  
  def start
    @game = Game.find(params[:id])
    @game.start
    @game.save

    redirect_to @game
  end
  
  private
    def game_params
      params.require(:game).permit(:name)
    end
    
    # def current_user
    #   current_user ||= Guest.create(name: "guest", email: rand.to_s + "@example.com")
    # end
    
    def create_guest
      guest = Guest.create(name: params[:name], email: rand.to_s + "@example.com")
      sign_in(guest)
    end
    
end