class AddNameToGameServer < ActiveRecord::Migration
  def change
    add_column :game_servers, :name, :string
  end
end
