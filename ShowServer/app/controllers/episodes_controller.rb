class EpisodesController < ApplicationController
  before_action :authenticate_user!

  def index
    @episodes = Show.find(params[:show_id]).episodes
    render json: @episodes
  end

  def show
    @episode = Episode.find(params[:id])
    render json: @episode
  end

  def add_watched
    if @episode = Episode.where(id: params[:id]).first
      unless current_user.episodes.include?(@episode)
        current_user.episodes << @episode
        render json: '{"apicall":"add_watched","status":"success"}'
      else
        render json: '{"apicall":"add_watched","status":"failure"}'
      end
    else
      render json: '{"apicall":"add_watched","status":"failure"}'
    end
  end

  def remove_watched
    if @episode = Episode.find(params[:id])
      if current_user.episodes.include?(@episode)
        current_user.episodes.delete(@episode)
        render json: '{"apicall":"remove_watched","status":"success"}'
      else
        render json: '{"apicall":"remove_watched","status":"failure"}'
      end
    else
        render json: '{"apicall":"remove_watched","status":"failure"}'
    end
  end

  def get_watched
    render json: current_user.episodes
  end
end
