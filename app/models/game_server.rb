class GameServer < ActiveRecord::Base
  validates :ip_address, :presence => true, :uniqueness => true
  validates :max_players, :presence => true
  
  attr_accessible :ip_address, :num_players, :max_players
end
