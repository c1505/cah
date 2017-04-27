json = File.read("cah.json")
parsed = JSON.parse(json)

black_cards = parsed["blackCards"]
white_cards = parsed["whiteCards"]

black_cards.each do |card|
  BlackCard.create(text: card["text"], blanks: card["pick"])
end

white_cards.each do |card|
  WhiteCard.create(text: card)
end

# i want players to not see the same cards in one game

# when possible, i want players to not see the same cards across multiple games

# the card chosen should be random for both white and black cards
