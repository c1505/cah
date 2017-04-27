class CreateWhiteCards < ActiveRecord::Migration[5.0]
  def change
    create_table :white_cards do |t|
      t.text :text
      t.references :user
      t.references :round

      t.timestamps
    end
  end
end
