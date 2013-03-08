class User < ActiveRecord::Base
  
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
  
  # friendships that are not reciprocated
  def requested_friends
    logger.info "inverse: #{inverse_friends.map{|f| f.id}}"
    logger.info "forward #{friends.map{|f| f.id}}"
    logger.info "requested #{inverse_friends.map{|f| f.id} - friends.map{|f| f.id}}"
    request_ids = inverse_friends.map{|f| f.id} - friends.map{|f| f.id}
    User.where(:id => request_ids)
  end
  
  # friendships that are reciprocated
  def confirmed_friends
    logger.info "inverse: #{inverse_friendships.map{|f| f.id}}"
    logger.info "forward #{friendships.map{|f| f.id}}"
    logger.info "confirmed #{inverse_friendships.map{|f| f.id} & friendships.map{|f| f.id}}"
    friend_ids = inverse_friends.map{|f| f.id} & friends.map{|f| f.id}
    User.where(:id => friend_ids)
  end
end
