class GamesController < ApplicationController
  def new
    @game = Game.new
  end

  def index
    @games = Game.all
  end

  def join
    @game = Game.find(params[:game_id])
    create_guest unless current_user
    @game.users << current_user
    @game.save
    redirect_to @game
  end

  def create
    game = Game.new(game_params)
    game.users << create_guest
    game.build_deck(params["other"]["sfw"])

    if game.save
      redirect_to game
    else
      render new_game_path
    end
  end

  def show
    @game = Game.find(params[:id])
    if @game.started?
      if user_in_game?
        @round = @game.rounds.last
        @black_card = @round.black_card
  
        @black_cards = @game.rounds.map do |round|
          round.black_card
        end
  
        @scores = score
  
        if @round.host == current_user
          @white_cards = @round.white_cards
        else
          @white_cards = current_user.white_cards
        end
      else
        flash[:alert] = "You cannot join a game already in progress"
        redirect_to root_path
      end
    end
  end

  def start
    @game = Game.find(params[:game_id])
    unless @game.started?
      if @game.users.count > 1
        @game.start(current_user)
        @game.save
      else
        flash[:alert] = "You must have more than 1 player in order to start a game"
      end
    end
    redirect_to @game
  end

  private
    def game_params
      params.require(:game).permit(:name)
    end

    def score #FIXME this can be done better with just a good SQL query
      game_score = @game.rounds.map {|f| f.winner }.compact.group_by{|i| i.id}
      game_score.map do |f|
        [f[1][0].name, f[1].count]
      end
    end
    
    def user_in_game?
      if current_user
        @game.users.include?(current_user)
      end
    end
          
    def create_guest
      guest = Guest.create(name: params[:name], email: rand.to_s + "@example.com")
      sign_in(guest)
    end

end
