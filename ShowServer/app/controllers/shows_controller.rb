require 'huluapi'

class ShowsController < ApplicationController
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
      redirect_to @show
    else
      logger.info "   Not Found: #{params[:name]}"
      @id = Show.load_from_hulu(params[:name])
      logger.info "Returned id: #{@id}"
      redirect_to Show.find_by(hulu_id: @id)
    end
  end

end
