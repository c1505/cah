# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
user = CreateAdminService.new.call
puts 'CREATED ADMIN USER: ' << user.email
# Environment variables (ENV['...']) can be set in the file .env file.

# CARDS #
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

#CARDS#
