class AddColumnsToBlackCards < ActiveRecord::Migration[5.0]
  def change
    add_column :black_cards, :game_id, :integer
  end
end