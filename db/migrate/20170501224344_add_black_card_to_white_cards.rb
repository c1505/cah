class AddBlackCardToWhiteCards < ActiveRecord::Migration[5.0]
  def change
    add_column :white_cards, :black_card_id, :integer
  end
end
