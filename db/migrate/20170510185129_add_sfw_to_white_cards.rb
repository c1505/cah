class AddSfwToWhiteCards < ActiveRecord::Migration[5.0]
  def change
    add_column :white_cards, :sfw, :boolean
  end
end
