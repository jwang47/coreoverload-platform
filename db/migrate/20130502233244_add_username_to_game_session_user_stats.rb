class AddUsernameToGameSessionUserStats < ActiveRecord::Migration
  def change
    add_column :game_session_user_stats, :username, :string
  end
end
