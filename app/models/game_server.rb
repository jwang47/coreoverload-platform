class GameServer < ActiveRecord::Base
  include GameServerHelper
  
  validates :ip_address, :presence => true, :uniqueness => true
  validates :max_players, :presence => true
  
  # disable max check until UDK game server implements it
  #validate :num_players_lt_max_players
  validate :num_players_gte_zero
  
  attr_accessible :ip_address, :max_players
  attr_accessible :started_at, :num_red_players, :num_blue_players
  
  def started_elapsed
    if self.started_at.nil?
      0.0 / 0.0
    else
      (Time.now.to_f - self.started_at.to_f).to_i
    end
  end
  
  def heartbeat_elapsed
    if self.started_at.nil?
      GS_HEARTBEAT_LIMIT + 1
    else
      (Time.now.to_f - self.heartbeat.to_f).to_i
    end
  end
  
  def num_players
    num_red_players + num_blue_players
  end
  
  def do_heartbeat
    self.heartbeat = Time.current()
  end
  
  # TODO: Allow game servers to revive themselves
  def self.checked_all
    all.each do |server|
      server.destroy() if server.heartbeat_elapsed() > GS_HEARTBEAT_LIMIT
    end
    
    all
  end
  
  def self.port_open?(ip, port, seconds=1)
    return false if !IPAddress.valid? ip
    return false if !port.is_a? Integer
    return false if port.to_i <= 0 || port.to_i > 65535
    
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
  
private
  
  def num_players_lt_max_players
    errors.add(:num_players, "should be less than max players") if num_players > max_players
  end
  
  def num_players_gte_zero
    errors.add(:num_players, "should be greater than or equal to 0") if num_players < 0
  end
 
end
