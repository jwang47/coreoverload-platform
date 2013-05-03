class UsersController < ApplicationController

  def index
    @users = User.all
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  # TODO: require user authentication
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      render :json => @user
    else
      render :json => { :errors => @user.errors.full_messages }, :status => :unprocessable_entity
    end
  end
  
  def show_recent
    @user = User.find(params[:id])
    @recent_session = @user.match_history[0]
    if @recent_session
      render :json => @recent_session
    else
      render :json => {}
    end
  end

end