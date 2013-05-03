class GameSession < ActiveRecord::Base
  has_many :stats, :class_name => "GameSessionUserStats"
  accepts_nested_attributes_for :stats
  
  attr_accessible :duration, :stats_attributes
  
  def as_json(options={})
    hash_info = super(options) 
    hash_info[:stats] = stats
    hash_info
  end
    
  def self.history
    GameSession.all(:order => "created_at desc", :limit => 10)
  end
end
