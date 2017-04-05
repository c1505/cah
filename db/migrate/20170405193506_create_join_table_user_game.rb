class CreateJoinTableUserGame < ActiveRecord::Migration[5.0]
  def change
    create_join_table :users, :games do |t|
      t.index [:user_id, :game_id]
    end
  end
end
