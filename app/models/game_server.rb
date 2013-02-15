class GameServer < ActiveRecord::Base
  validates :ip_address, :presence => true, :uniqueness => true
  validates :max_players, :presence => true
  
  # disable max check until UDK game server implements it
  #validate :num_players_lt_max_players
  validate :num_players_gte_zero
  
  attr_accessible :ip_address, :num_players, :max_players, :heartbeat
  
  def do_heartbeat
    self.heartbeat = Time.current()
  end
  
private
  
  def num_players_lt_max_players
    errors.add(:num_players, "should be less than max players") if num_players > max_players
  end
  
  def num_players_gte_zero
    errors.add(:num_players, "should be greater than or equal to 0") if num_players < 0
  end
 
end
