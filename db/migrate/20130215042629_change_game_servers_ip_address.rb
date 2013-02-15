class ChangeGameServersIpAddress < ActiveRecord::Migration
  def up
    change_column :game_servers, :ip_address, :string, :unique => true
  end

  def down
    add_column :game_servers, :ip_address, :string
  end
end
