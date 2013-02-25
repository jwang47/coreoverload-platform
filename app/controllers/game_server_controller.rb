class GameServerController < ApplicationController
  
  def check_servers
    GameServer.check_servers()
    redirect_to game_server_index_path
  end
  
  def index
    @game_servers = GameServer.checked_all
    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @game_servers }
    end
  end
  
  def show
    @game_server = GameServer.find(params[:id])
    render :json => @game_server
  end
  
  def create
    existing_server = GameServer.where(:ip_address => params[:game_server][:ip_address])
    if existing_server.exists?
      render :json => existing_server.first and return
    end
    @game_server = GameServer.create(params[:game_server])
    @game_server.do_heartbeat()
    save_and_render(@game_server)
  end
  
  def update
    @game_server = GameServer.find(params[:id])
    if @game_server.update_attributes(params[:game_server])
      render :json => @game_server
    else
      render :json => { :errors => game_server.errors.full_messages }, :status => :unprocessable_entity
    end
  end
  
  def destroy
    @game_server = GameServer.find(params[:id])
    if @game_server.destroy
      head :ok
    else
      render :json => { :errors => game_server.errors.full_messages }, :status => :unprocessable_entity
    end
  end
  
  def heartbeat
    @game_server = GameServer.find(params[:id])
    @game_server.do_heartbeat()
    save_and_render(@game_server)
  end
  
private

  def save_and_render(game_server)
    if game_server.save
      render :json => game_server
    else
      render :json => { :errors => game_server.errors.full_messages }, :status => :unprocessable_entity
    end
  end
  
end
