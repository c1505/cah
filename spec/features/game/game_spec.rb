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
  

end
