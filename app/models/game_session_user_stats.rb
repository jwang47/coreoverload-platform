class GameSessionUserStats < ActiveRecord::Base
  belongs_to :user
  belongs_to :game_session
  
  attr_accessible :user_id, :score, :victory, :kills, :deaths,
    :capture_point_count, :capture_point_points, :capture_point_time,
    :flags_captured_count, :flags_captured_points
    
end
