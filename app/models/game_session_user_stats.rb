class GameSessionUserStats < ActiveRecord::Base
  belongs_to :user
  belongs_to :game_session
  
  attr_accessible :victory, :capture_point_count, :capture_point_points, :capture_point_time, :deaths, :flags_captured_count, :flags_captured_points, :kills, :user_id
end
