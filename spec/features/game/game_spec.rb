require "rails_helper"


feature 'game' do
  before :all do 
    seed
  end
  
  scenario 'sfw white cards' do 
    visit root_path
    click_link "New Game"
    
    fill_in "Name", :with => "First Game"
    check "other_sfw"
    click_button "Create Game"

    expect(Game.last.white_cards.count).to eq 30 #FIXME Will break once I include more cards.  Maybe just have a smaller test set to seed with.  
  end
  
  scenario 'nsfw white cards' do 
    visit root_path
    click_link "New Game"
    
    fill_in "Name", :with => "First Game"
    click_button "Create Game"

    expect(Game.last.white_cards.count).to eq 40 #FIXME Will break once I include more cards.  Maybe just have a smaller test set to seed with.  
  end
  
  scenario 'user has 7 whitecards to start the game' do 
    visit root_path
    click_link "New Game"
    
    fill_in "Name", :with => "First Game"
    click_button "Create Game"
    click_button "Start Game"
    
    expect(User.last.white_cards.count).to eq 7
  end
  
  scenario 'join a game' do
    visit root_path
    click_link "New Game"
    
    fill_in "Name", :with => "First Game"
    click_button "Create Game"
    logout(User.last)
    visit '/games/1'
    expect(page).to have_text "Join Game"
    click_button "Join Game"
  end
  
  scenario 'user has played whitecard removed and a new whitecard dealt each round' do 
    visit root_path
    click_link "New Game"
    
    fill_in "Name", :with => "First Game"
    click_button "Create Game"
    click_button "Start Game"
    
    click_button "first card"
    expect(User.last.white_cards.count).to eq 7
    
  end
  
  scenario 'dealt white_card is removed from game'
  
  
  def seed
    json = File.read("cah.json")
    parsed = JSON.parse(json)
    
    black_cards = parsed["blackCards"]
    
    
    black_cards.sample(5).each do |card|
      BlackCard.create(text: card["text"], blanks: card["pick"])
    end
    
    
    sfw_json = File.read("sfw_whiteCards.json")
    sfw_white_cards = JSON.parse(sfw_json)
    
    sfw_white_cards = sfw_white_cards["whiteCards"]
    
    sfw_white_cards.sample(30).each do |card|
      WhiteCard.create(text: card, sfw: true)
    end
    
    
    nsfw_json = File.read("nsfw_whiteCards.json")
    nsfw_white_cards = JSON.parse(nsfw_json)
    
    nsfw_white_cards = nsfw_white_cards["whiteCards"]
    
    nsfw_white_cards.sample(10).each do |card|
      WhiteCard.create(text: card, sfw: false)
    end
  end
  
  # scenario 'create game game' do
  #   visit root_path
  #   expect(page).to have_link 'New Game'
  #   click_link "New Game"
    
  #   expect(page).to have_button "Create Game"
  #   fill_in "Name", :with => "First Game"
  #   click_button "Create Game"
    
  #   expect(page).to have_text "First Game"
  # end
  
  # scenario 'game has players' do
  #   visit root_path
  #   click_link "New Game"
    
  #   fill_in "Name", :with => "Player Test Game"
  #   click_button "Create Game"
    
  #   expect(page).to have_text "Players: 1"
  # end
  
  # scenario 'create game as a guest user' do
  #   visit root_path
  #   click_link "New Game as Guest"
    
  #   # fill_in "Game Name", :with => "Bob"
    
  #   fill_in "Name", :with => "Player Test Game"
  #   click_button "Create Game"
    
  #   expect(page).to have_text "Players: 1"
  # end
  

    
  

  
  # scenario 'join game as guest'
  
  # scenario 'join game as registered user'
  
  # scenario 'start game' do 
  #   seed_cards
  #   game_ready
  #   click_button "Start Game"
  #   # see black card text
  #   # see number of cards submitted
  #   expect(page).to have_text("cards submitted")
  # end
  
  # def game_ready
  #   game = Game.create
  #   bob = Guest.create(name: "bob", email: rand.to_s + "@example.com")
  #   game.users << bob
  #   visit "games/1"
  #   fill_in "Name", :with => "carl"
  #   click_button "Join Game"
  #   game.save
  #   visit '/games/1'
  #   expect(page).to have_text("bob")
  # end
  

    
    
  

  

end
