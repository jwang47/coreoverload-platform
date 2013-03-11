class FriendshipsController < ApplicationController
  
  def create
    @friendship = current_user.friendships.build(:friend_id => params[:friend_id])
    if @friendship.save
      flash[:notice] = "Added friend."
      redirect_to :back
    else
      flash[:notice] = "Unable to add friend."
      redirect_to :back
    end
  end
  
  def destroy
    @friendship = current_user.friendships.find(params[:id])
    logger.info "Destroying friendship between #{@friendship.user.email} and #{@friendship.friend.email}"
    if @friendship.destroy and current_user.save
      flash[:notice] = "destroyed friendship"
      redirect_to :back
    else
      flash[:notice] = "unable to destroy friendship"
      redirect_to :back
    end
  end
  
  def index
    @friendships = current_user.friendships
  end
  
end