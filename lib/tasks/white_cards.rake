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

end
