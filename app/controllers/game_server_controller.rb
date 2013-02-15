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
    save_and_render(@game_server)
  end
  
  def update
    
  end
  
  def destroy
    
  end
  
  def heartbeat
    @game_server = GameServer.find(params[:id])
    @game_server.do_heartbeat()
    save_and_render(@game_server)
  end
  
  def player_add
    @game_server = GameServer.find(params[:id])
    # @player = params[:player_id]
    @game_server.num_players = @game_server.num_players + 1
    save_and_render(@game_server)
  end
  
  def player_remove
    @game_server = GameServer.find(params[:id])
    # @player = params[:player_id]
    @game_server.num_players = @game_server.num_players - 1
    save_and_render(@game_server)
  end
  
private

  def save_and_render(game_server)
    if game_server.save
      render :json => game_server
    else
      render :json => { :errors => game_server.errors.full_messages }, :status => 422
    end
  end
  
end
