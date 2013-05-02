class GameSessionUserStats < ActiveRecord::Base
  belongs_to :user
  belongs_to :game_session
  
  attr_accessible :username # can be blank for registered users (use user.name); should not be blank for unregistered users
  attr_accessible :user_id, :score, :victory, :kills, :deaths,
    :capture_point_count, :capture_point_points, :capture_point_time,
    :flags_captured_count, :flags_captured_points
    
  def display_name
    if user_id == nil
      username
    else
      User.find(user_id).email
    end
  end
    
end
