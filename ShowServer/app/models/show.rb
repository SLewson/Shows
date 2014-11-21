require 'huluapi'

class Show < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_many :episodes

  def self.load_from_hulu(show_name)
    @hulu_api = HuluApi.new
    @response = Hash.from_xml(@hulu_api.search(URI::encode(show_name), 10, 1))
    @id = -1
    logger.info "Hitting Hulu API For: #{show_name}"

    @response['results']['videos'].each do |video|
      logger.info "Looking for #{show_name}, found #{video['show_name']}"
      unless Show.find_by(hulu_id: video['show']['id']).present?
        logger.info "Probably not getting here"
        id = video['show']['id']
        name = video['show_name']
        @show = Show.create(hulu_id: id, name: name)
        logger.info "   Found: #{id}, #{name}"
        @id = id if name.downcase.eql? show_name.downcase
      end
    end
    load_episodes(@id, @show)
    return @id
  end

def self.load_episodes(show_id, show)
# import episodes
  logger.info "\n\n ----- LOAD EPISODES #{show_id}-----\n\n"

  logger.info "retrieving episodes for show with id #{show_id}"
  episodes = Hash.from_xml(@hulu_api.get_videos_for_show_by_id(show_id, 10, "name%20asc", 1, 0))

  episodes['videos']['video'].each do |episode|
    unless Episode.find_by(hulu_video_id: episode['video_id']).present?
      ep_id = episode['video_id']
      ep_name = episode['title']
      ep_show_id = episode['show_id']
      ep_description = episode['description']
      ep_type = episode['video_type']
      logger.info "Show: #{show_id}: found episode #{ep_name} from show #{ep_show_id}"
      if ep_show_id.to_s.eql? show_id.to_s
        logger.info "Creating episode for #{ep_id}: #{ep_name}"
        Episode.create(hulu_video_id: ep_id.to_i, name: ep_name, description: ep_description, show: show)
      end
    end
  end
end

end
