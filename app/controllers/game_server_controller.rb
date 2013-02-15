class GameServerController < ApplicationController
  
  def index
    @game_servers = GameServer.all
    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @game_servers }
    end
  end
  
  
  def create
    @game_server = GameServer.create(params[:game_server])
    if @game_server.save
      render :json => @game_server
    else
      logger.info @game_server.errors.full_messages
      render :json => { :errors => @game_server.errors.full_messages }, :status => 422
    end
  end
  
  def update
    
  end
  
  def destroy
    
  end
  
end
