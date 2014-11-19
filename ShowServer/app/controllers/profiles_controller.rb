
class ProfilesController < ApplicationController
  def index
      @users = User.all
      render json: @users
  end

  def show
      @show = Show.find(params[:id])
      render json: @show
  end

  def add_favorite
    @show = Show.find(params[:id])
    current_user.shows << @show
    #logger.info "add_favorte #{params[:id]}"
    render json: '{"status":"success"}'
    #render json: current_user.shows
  end

  def get_favorites
    render json: current_user.shows
  end

end
