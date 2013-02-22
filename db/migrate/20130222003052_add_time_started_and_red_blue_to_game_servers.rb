class AddTimeStartedAndRedBlueToGameServers < ActiveRecord::Migration
  def change
    add_column :game_servers, :started_at, :timestamp
    add_column :game_servers, :num_red_players, :integer, :default => 0
    add_column :game_servers, :num_blue_players, :integer, :default => 0
  end
end
