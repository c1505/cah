class CreateJoinTableRoundsWhitecards < ActiveRecord::Migration[5.0]
  def change
    create_join_table :rounds, :white_cards do |t|
      t.index [:round_id, :white_card_id]
    end
  end
end