require "rails_helper"

feature 'game' do
  before :each do
    seed
  end

  scenario 'start game with sfw white cards' do
    visit root_path
    click_link "New Game"

    fill_in "Name", :with => "First Game"
    check "other_sfw"
    click_button "Create Game"

    expect(Game.last.white_cards.count).to eq 30 #FIXME Will break once I include more cards.  Maybe just have a smaller test set to seed with.
  end

  scenario 'start game with nsfw white cards' do
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

scenario 'same white card can be used by players of 2 different games'

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

    sfw_white_cards.sample(10).each do |card|
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
