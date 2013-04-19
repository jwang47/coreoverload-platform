class AddGameSessionIdToGameSessionUserStats < ActiveRecord::Migration
  def change
    add_column :game_session_user_stats, :game_session_id, :integer
  end
end
