namespace :white_cards do
  desc "Go through base white cards and assign true false values to sfw attribute"
  task sfw: :environment do
    
    WhiteCard.all.each do |f|
      puts f.text
      input = STDIN.gets.chomp
      if input == "f"
        f.sfw = false
      elsif input == "t"
        f.sfw = true
      end
      f.save
    end
  end
  
  task sfw_to_json: :environment do
    white_cards = WhiteCard.sfw.map do |card|
      card.text
    end
    white_cards_hash = {"whiteCards" => white_cards}
    File.open('sfw_whiteCards.json', 'w') {|file| file.write(white_cards_hash.to_json)}
  end

end
