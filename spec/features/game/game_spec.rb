require "rails_helper"

feature 'game' do

  scenario 'start game with sfw white cards' do
    visit root_path
    click_link "New Game"

    fill_in "Name", :with => "First Game"
    check "other_sfw"
    click_button "Create Game"

    expect(Game.last.white_cards.count).to eq 327 #FIXME Will break once I include more cards.  Maybe just have a smaller test set to seed with.
  end

  scenario 'start game with nsfw white cards' do
    visit root_path
    click_link "New Game"

    fill_in "Name", :with => "First Game"
    click_button "Create Game"

    expect(Game.last.white_cards.count).to eq 460 #FIXME Will break once I include more cards.  Maybe just have a smaller test set to seed with.
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
    logout
    visit '/games/1'
    fill_in "name", :with => "Second Player"
    click_button "Join Game"
    expect(Game.last.users.count).to eq 2
  end

  scenario 'player can play white card', js: true, type: :feature do
    visit root_path
    click_link "New Game"

    fill_in "Name", :with => "First Game"
    click_button "Create Game"
    logout
    visit '/games/1'
    fill_in "name", :with => "Second Player"
    click_button "Join Game"
    click_button "Start Game"
    logout
    login_as(User.first)
    visit '/games/1'
    within first"div.light.stackcard" do
      find(:css, 'li').click
    end
    expect(page).to have_text "Card submitted: #{User.first.white_cards.first.text.html_safe}"
  end

  scenario 'score is displayed', js: true, type: :feature do
    white_card = player_submit

    logout
    login_as(User.last)
    visit '/games/1'
    white_card_css_id = "white_card_" + white_card.id.to_s
    expect(page).to have_text "Cards Submitted"
    choose(white_card_css_id) #FIXME this fails often.
    click_button "Choose Winner"
    expect(page).to have_text "The winner is: #{white_card.text.html_safe}"
    expect(Round.first.winner.id).to eq User.first.id

    expect(page).to have_text "Scores: Name: - Black Cards: 1"
  end

  scenario 'dealer can submit winning card', js: true, type: :feature do
    white_card = player_submit

    logout
    login_as(User.last) #maybe this sometime leads to wrong user?
    visit '/games/1'
    white_card_css_id = "white_card_" + white_card.id.to_s
    expect(page).to have_text "Cards Submitted"
    choose(white_card_css_id) #FIXME this fails often.  seems like it might be timing outq
    click_button "Choose Winner"
    binding.pry
    expect(page).to have_text "The winner is: #{white_card.text.html_safe}"
    expect(Round.first.winner.id).to eq User.first.id
  end

scenario 'player can only submit one card', js: true, type: :feature do
  player_submit

  visit '/games/1'
  within first"div.light.stackcard" do
    find(:css, 'li').click
  end

  expect(Round.last.white_cards.count).to eq 1
end

scenario 'same white card can be used in different games by different players in different games'



  private

  def player_submit
    visit root_path
    click_link "New Game"

    fill_in "Name", :with => "First Game"
    check "other_sfw"
    click_button "Create Game"
    logout
    visit '/games/1'
    fill_in "name", :with => "Second Player"
    click_button "Join Game"
    click_button "Start Game"
    logout
    login_as(User.first)
    visit '/games/1'
    white_card = User.first.white_cards.first
    within first"div.light.stackcard" do
      find(:css, 'li').click
    end

    white_card_text = User.first.white_cards.first.text.html_safe
    expect(page).to have_text "Card submitted: #{white_card_text}"
    white_card
  end

  def player_submit_game_2
    visit root_path
    click_link "New Game"

    fill_in "Name", :with => "First Game"
    check "other_sfw"
    click_button "Create Game"
    logout
    visit '/games/1'
    fill_in "name", :with => "Second Player"
    click_button "Join Game"
    click_button "Start Game"
    logout
    login_as(User.first)
    visit '/games/2'
    white_card = User.first.white_cards.first
    within first"div.light.stackcard" do
      find(:css, 'li').click
    end

    white_card_text = User.first.white_cards.first.text.html_safe
    expect(page).to have_text "Card submitted: #{white_card_text}"
    white_card
  end


  scenario 'game has players'

  scenario 'create game as a guest user'

  scenario 'join game as guest'

  scenario 'join game as registered user'



end
