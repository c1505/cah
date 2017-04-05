require "rails_helper"

feature 'game' do
  scenario 'start game' do
    visit root_path
    expect(page).to have_link 'New Game'
    click_link "New Game"
    
    expect(page).to have_button "Create Game"
    fill_in "Name", :with => "First Game"
    click_button "Create Game"
    
    expect(page).to have_text "First Game"
  end

end
