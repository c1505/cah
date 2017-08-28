class AddColumnsToWhiteCards < ActiveRecord::Migration[5.0]
  def change
    add_column :white_cards, :game_id, :integer
  end
end