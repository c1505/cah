class WhiteDeck < ActiveRecord::Migration[5.0]
  def change
    create_join_table(:games, :white_cards, table_name: "white_decks") do |t|
      t.index [:game_id, :white_card_id]
    end
  end
end