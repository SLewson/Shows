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
      redirect_to(action: 'show', id: Show.find_by(hulu_id: @id).id, user_token: params[:user_token])
    end
  end

end
