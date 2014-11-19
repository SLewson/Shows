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
        #loadEpisodes(id)
    return @id
  end

end
