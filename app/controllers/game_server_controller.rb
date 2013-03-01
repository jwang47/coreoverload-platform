class GameServerController < ApplicationController
  
  def check_servers
    GameServer.check_servers()
    redirect_to game_server_index_path
  end
  
  def index
    
    if params[:debug]
      @game_servers = [
        GameServer.new(:ip_address => '185.32.95.1', :max_players => 10, :num_red_players => 3, :num_blue_players => 4, :started_at => 5.minutes.ago),
        GameServer.new(:ip_address => '78.5.23.253', :max_players => 12, :num_red_players => 1, :num_blue_players => 6, :started_at => 1.minutes.ago),
        GameServer.new(:ip_address => '243.128.32.244', :max_players => 10, :num_red_players => 2, :num_blue_players => 7, :started_at => 10.minutes.ago),
        GameServer.new(:ip_address => '127.0.0.1', :max_players => 10, :num_red_players => 2, :num_blue_players => 7, :started_at => 10.minutes.ago),
        #GameServer.new(:ip_address => 'glados1.isi.edu', :max_players => 10, :num_red_players => 1, :num_blue_players => 1, :started_at => 1.minutes.ago),
        GameServer.new(:ip_address => '128.9.136.225', :max_players => 10, :num_red_players => 6, :num_blue_players => 4, :started_at => 8.minutes.ago)
      ]
      respond_to do |format|
        format.html # index.html.erb
        format.json { render :json => @game_servers }
      end
    else
      @game_servers = GameServer.checked_all
      respond_to do |format|
        format.html # index.html.erb
        format.json { render :json => @game_servers }
      end
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
