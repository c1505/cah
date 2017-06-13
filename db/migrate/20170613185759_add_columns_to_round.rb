class AddColumnsToRound < ActiveRecord::Migration[5.0]
  def change
    add_column :rounds, :winner_id, :integer
    add_column :rounds, :winning_white_card_id, :integer
  end
end
