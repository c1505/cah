class BlackDeck < ActiveRecord::Migration[5.0]
  def change
    create_join_table(:games, :black_cards, table_name: "black_decks") do |t|
      t.index [:game_id, :black_card_id]
    end
  end
end