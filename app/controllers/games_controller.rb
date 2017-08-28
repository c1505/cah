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
    if game.save
      game.build_deck(params["other"]["sfw"],1000)
      redirect_to game
    else
      render new_game_path
    end
  end

  def show
    @game = Game.find(params[:id])

    if @game.started?
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
    end
  end

  def start
    @game = Game.find(params[:game_id])
    @game.start(current_user)
    @game.save

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

    # def current_user
    #   current_user ||= Guest.create(name: "guest", email: rand.to_s + "@example.com")
    # end

    def create_guest
      guest = Guest.create(name: params[:name], email: rand.to_s + "@example.com")
      sign_in(guest)
    end

end
