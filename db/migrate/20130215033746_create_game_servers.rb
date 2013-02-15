class CreateGameServers < ActiveRecord::Migration
  def change
    create_table :game_servers do |t|
      t.string :ip_address
      t.integer :num_players, :default => 0
      t.integer :max_players, :default => 10

      t.timestamps
    end
  end
end
