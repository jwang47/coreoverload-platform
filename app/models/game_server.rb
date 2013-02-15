class GameServer < ActiveRecord::Base
  include GameServerHelper
  
  validates :ip_address, :presence => true, :uniqueness => true
  validates :max_players, :presence => true
  
  # disable max check until UDK game server implements it
  #validate :num_players_lt_max_players
  validate :num_players_gte_zero
  
  attr_accessible :ip_address, :num_players, :max_players, :heartbeat
  
  
  def self.port_open?(ip, port, seconds=1)
    Timeout::timeout(seconds) do
      begin
        u = TCPSocket.new(ip, port).close()
        true
      rescue Errno::ECONNREFUSED, Errno::EHOSTUNREACH
        false
      end
    end
  rescue Timeout::Error
    false
  end

  def self.check_servers
    threads = []
    GameServer.all.each do |server|
      threads << Thread.new(server) { |my_server|
        server.destroy() unless port_open?(server.ip_address, 7777)
      }
    end
    threads.each { |thread| thread.join() }
  end
  
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
