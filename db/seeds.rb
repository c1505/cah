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


black_cards.each do |card|
  BlackCard.create(text: card["text"], blanks: card["pick"])
end


sfw_json = File.read("sfw_whiteCards.json")
sfw_white_cards = JSON.parse(sfw_json)

sfw_white_cards = sfw_white_cards["whiteCards"]

sfw_white_cards.each do |card|
  WhiteCard.create(text: card, sfw: true)
end


nsfw_json = File.read("nsfw_whiteCards.json")
nsfw_white_cards = JSON.parse(nsfw_json)

nsfw_white_cards = nsfw_white_cards["whiteCards"]

nsfw_white_cards.each do |card|
  WhiteCard.create(text: card, sfw: false)
end

#CARDS#
