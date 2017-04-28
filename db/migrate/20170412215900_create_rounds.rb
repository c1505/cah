class CreateRounds < ActiveRecord::Migration[5.0]
  def change
    create_table :rounds do |t|
      t.references :game
      t.integer :number
      t.references :user

      t.timestamps
    end
  end
end
