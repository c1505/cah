class Add_BlackCard_to_white_cards < ActiveRecord::Migration[5.0]
  def change
    add_column :black_card_id, :integer
  end
end
