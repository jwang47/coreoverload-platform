class AddScoreToGameSessionUserStats < ActiveRecord::Migration
  def change
    add_column :game_session_user_stats, :score, :float
  end
end
