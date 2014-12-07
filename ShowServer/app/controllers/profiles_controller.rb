class ProfilesController < ApplicationController
  before_action :authenticate_user!

  def index
      @users = User.all
      render json: @users
  end

  def show
      @show = Show.find(params[:id])
      render json: @show
  end

  def add_favorite
    if @show = Show.find(params[:id])
      if !current_user.shows.include?(@show)
        current_user.shows << @show
        render json: '{"status":"success"}'
      else
        render json: '{"status":"repeat"}'
      end
    else
      render json: '{"status":"not found"}'
    end
  end

  def remove_favorite
    if @show = Show.find(params[:id])
      if current_user.shows.include?(@show)
        current_user.shows.delete(@show)
        render json: '{"status":"deleted"}'
      else
        render json: '{"status":"not a favorite"}'
      end
    else
      render json: '{"status":"show not in database"}'
    end
  end

  def get_favorites
    render json: current_user.shows
  end

end
