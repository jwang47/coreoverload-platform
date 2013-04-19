class User < ActiveRecord::Base
  
  has_many :game_session_user_stats, :class_name => "GameSessionUserStats"
  
  has_many :friendships
  has_many :friends, :through => :friendships
  
  has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id"
  has_many :inverse_friends, :through => :inverse_friendships, :source => :user
  
  # Include default devise modules. Others available are:
  # :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :token_authenticatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body
  
  def match_history
    logger.info game_session_user_stats
    game_session_user_stats.all(:order => "created_at desc", :limit => 10)
  end
  
  def outgoing_requested_friends
    request_ids = friends.map{|f| f.id} - inverse_friends.map{|f| f.id}
    User.where(:id => request_ids)
  end
  
  # friendships that are not reciprocated by this user
  def incoming_requested_friends
    request_ids = inverse_friends.map{|f| f.id} - friends.map{|f| f.id}
    User.where(:id => request_ids)
  end
  
  # friendships that are reciprocated by this user
  def confirmed_friends
    friend_ids = inverse_friends.map{|f| f.id} & friends.map{|f| f.id}
    User.where(:id => friend_ids)
  end
end
