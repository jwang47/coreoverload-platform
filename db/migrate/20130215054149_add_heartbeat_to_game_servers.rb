class AddHeartbeatToGameServers < ActiveRecord::Migration
  def change
    add_column :game_servers, :heartbeat, :timestamp
  end
end
