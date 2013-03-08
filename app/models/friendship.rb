class Friendship < ActiveRecord::Base
  belongs_to :user
  belongs_to :friend, :class_name => 'User'
  attr_accessible :friend, :user
  attr_accessible :friend_id, :user_id
  
  validates_presence_of :user, :friend
end
