class CreateGameSessionUserStats < ActiveRecord::Migration
  def change
    create_table :game_session_user_stats do |t|
      t.integer :user_id
      t.boolean :victory
      t.integer :kills
      t.integer :deaths
      t.integer :flags_captured_count
      t.integer :flags_captured_points
      t.integer :capture_point_count
      t.integer :capture_point_time
      t.integer :capture_point_points

      t.timestamps
    end
  end
end
