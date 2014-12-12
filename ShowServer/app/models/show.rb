require 'huluapi'

class Show < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_many :episodes

  def self.load_from_hulu(show_name)
    @hulu_api = HuluApi.new
    @response = Hash.from_xml(@hulu_api.search(URI::encode(show_name), 10, 1)[1])
    @id = -1
    logger.info "Hitting Hulu API For: #{show_name}"

    @response['results']['videos'].each do |video|
      logger.info "Looking for #{show_name}, found #{video['show_name']}"
      unless Show.find_by(hulu_id: video['show']['id']).present?
        logger.info "Probably not getting here"
        id = video['show']['id']
        name = video['show_name']
        description = video['show']['description']
        genre = video['show']['genre']
        logger.info "Genre: #{genre}, Description: #{description}"
        @show = Show.create(hulu_id: id, name: name, description: description, genre: genre)
        logger.info "   Found: #{id}, #{name}"
        @id = id if name.downcase.eql? show_name.downcase
      end
    end
    load_all_episodes(@id, @show)
    return @id
  end

  def self.load_episodes(show_id, show, page)
  # import episodes
    logger.info "\n\n ----- LOAD EPISODES #{show_id}-----\n\n"

    @hulu_api = HuluApi.new

    logger.info "retrieving episodes for show with id #{show_id}"
    hulu_response = @hulu_api.get_videos_for_show_by_id(show_id, 25, "name%20asc", page, 0)
    episodes = Hash.from_xml(hulu_response[1])

    return hulu_response[0] if episodes.nil? || episodes['videos'].nil?

    episodes['videos']['video'].each do |episode|
      unless Episode.find_by(hulu_video_id: episode['video_id']).present?
        ep_id = episode['video_id']
        ep_name = episode['title']
        ep_show_id = episode['show_id']
        ep_description = episode['description']
        ep_type = episode['video_type']
        ep_rating = episode['rating']
        logger.info "Show: #{show_id}: found episode #{ep_name} from show #{ep_show_id}"
        if ep_show_id.to_s.eql? show_id.to_s
          logger.info "Creating episode for #{ep_id}: #{ep_name}"
          Episode.create(hulu_video_id: ep_id.to_i, name: ep_name, description: ep_description, show: show, rating: ep_rating)
        end
      end
    end

    return hulu_response[0]
  end

  def self.load_all_episodes(show_id, show)
    page = 1

    loop do
      episodes_response = self.load_episodes(show_id, show, page)
      page = page + 1
      Rails.logger.info "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
      Rails.logger.info "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
      Rails.logger.info "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
      Rails.logger.info "response what is this #{episodes_response[0]}"

      break if episodes_response[0] != "2"
    end
  end

end
