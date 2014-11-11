require 'huluapi'
require 'logger'

namespace :shows do
    task :hulu_import, [:show_name] => :environment do |t, args|
        @hulu_api = HuluApi.new
        @response = Hash.from_xml(@hulu_api.search(args.show_name, 10, 1))

        logger.info "Hitting Hulu API For: #{args.show_name}"

        @response['results']['videos'].each do |video|
            unless Show.find_by(name: video['show_name']).present?
                id = video['show']['id']
                name = video['show_name']
                @show = Show.create(hulu_id: id, name: name)
                logger.info "   Found: #{id}, #{name}"
            end
        end
    end
end
