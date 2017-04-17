require "rails_helper"

feature 'game' do
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
  
  scenario 'create game as a guest user' do
    visit root_path
    click_link "New Game as Guest"
    
    # fill_in "Game Name", :with => "Bob"
    
    fill_in "Name", :with => "Player Test Game"
    click_button "Create Game"
    
    expect(page).to have_text "Players: 1"
  end
  
  scenario 'join a game' do
    Game.create
    visit "games/1"
    expect(page).to have_button "Join Game"
    fill_in "Name", :with => "Join Test"
    click_button "Join Game"
    
    expect(page).to have_text "Join Test"
  end
  
  # scenario 'join game as guest'
  
  # scenario 'join game as registered user'
  
  scenario 'start game' do 
    game_ready
    click_button "Start Game"
    expect(page).to have_text("Black Card")
    expect(page).to have_text("cards submitted")
  end
  
  def game_ready
    game = Game.create
    bob = Guest.create(name: "bob", email: rand.to_s + "@example.com")
    game.users << bob
    visit "games/1"
    fill_in "Name", :with => "carl"
    click_button "Join Game"
    game.save
    visit '/games/1'
    expect(page).to have_text("bob")
  end
    
    
  

  

end