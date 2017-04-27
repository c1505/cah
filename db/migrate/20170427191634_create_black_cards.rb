class CreateBlackCards < ActiveRecord::Migration[5.0]
  def change
    create_table :black_cards do |t|
      t.text :text
      t.integer :blanks
      t.references :user
      t.references :round

      t.timestamps
    end
  end
end
