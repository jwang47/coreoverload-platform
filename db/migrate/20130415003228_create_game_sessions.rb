class CreateGameSessions < ActiveRecord::Migration
  def change
    create_table :game_sessions do |t|
      t.integer :duration

      t.timestamps
    end
  end
end
