class GameSessionController < ApplicationController
  
  # process game session info
  # format:
  # {stats_attributes [{user_id: 13, kills: 3, deaths: 2, ..}, {user_id: 32, ..}, {user_id: 52, ..} ]}
  def create
    @game_session = GameSession.create(params[:game_session])
    #@game_session.stats.build
    save_and_render(@game_session)
  end
  
  def show
    @game_session = GameSession.find(params[:id])
    respond_to do |format|
      format.html
      format.json { render :json => @game_session.to_json }
    end
  end
  
private

  def save_and_render(model)
    if model.save
      render :json => model
    else
      render :json => { :errors => model.errors.full_messages }, :status => :unprocessable_entity
    end
  end
  
end
