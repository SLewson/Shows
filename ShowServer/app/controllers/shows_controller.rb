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
    if @show = Show.find_by(name: params[:name])
      redirect_to @show
    else
      @hulu_api = HuluApi.new
      @response = Hash.from_xml(@hulu_api.search(URI::encode(params[:name]), 10, 1))

      logger.info "Hitting Hulu API For: #{params[:name]}"

      @response['results']['videos'].each do |video|
        unless Show.find_by(hulu_id: video['show']['id']).present?
          id = video['show']['id']
          name = video['show_name']
          @show = Show.create(hulu_id: id, name: name)
          logger.info "   Found: #{id}, #{name}"
          @id = id if name.downcase.eql? params[:name].downcase

          # import episodes
          episodes = Hash.from_xml(@hulu_api.get_videos_for_show_by_id(id, 100, "asc", 1, 0))
          logger.info episodes
          episodes['videos']['video'].each do |episode|
            unless Episode.find_by(hulu_video_id: episode['video_id']).present?
              ep_id = episode['video_id']
              ep_name = episode['title']
              ep_show_id = episode['show_id']
              ep_description = episode['description']
              ep_type = episode['video_type']

              logger.info "Creating episodes... #{@show.hulu_id} #{ep_show_id}."
              #if ep_show_id.eql? @show.hulu_id.to_s
              Episode.create(hulu_video_id: ep_id.to_i, name: ep_name, description: ep_description, show: @show)
              #end
            end
          end
        end
      end

      redirect_to Show.find_by(hulu_id: @id)
    end
  end
end
