require 'huluapi'

class ShowsController < ApplicationController
  before_action :authenticate_user!

  def index
      @shows = Show.all
      render json: @shows
  end

  def show
      @show = Show.find(params[:id])
      render json: @show
  end

  def search
    logger.info "Searching for: #{params[:name]}"
    if @show = Show.find_by(name: params[:name].titleize)
      logger.info "   Found: #{params[:name]}"
      redirect_to(action: 'show', id: @show.id, user_token: params[:user_token])
    else
      logger.info "   Not Found: #{params[:name]}"
      @id = Show.load_from_hulu(params[:name])
      logger.info "Returned id: #{@id}"

      if Show.find_by(hulu_id: @id).present?
        redirect_to(action: 'show', id: Show.find_by(hulu_id: @id).id, user_token: params[:user_token])
      else
        render json: '{"status":"failure","message":"No show found"}'
      end
    end
  end

  def search_v2
    Show.load_from_hulu(params[:name])
    connection = ActiveRecord::Base.connection
    results = connection.execute("SELECT 'shows'.* FROM 'shows' WHERE 'shows'.'name' LIKE '%#{params[:name]}%'")
    render json: results
  end
end
