require 'net/http'
require 'json'

class HuluApi

  ARROW_ID = "11430"

  DP_ID = "dp_id=hulu"
  BASE_URL = "http://m.hulu.com/"
  BUILD_URL = BASE_URL + "%s?" + DP_ID
  SEARCH_URL = "http://m.hulu.com/search?dp_identifier=%s&query=%s&items_per_page=%d&page=%d"

  TYPE_SEARCH = "search"
  TYPE_CHANNELS = "channels"
  TYPE_SHOWS = "shows"
  TYPE_VIDEOS = "videos"
  TYPE_COMPANIES = "companies"

  KEY_LIMIT = "limit"
  KEY_ORDER_BY = "order_by"
  KEY_TOTAL = "total"
  KEY_PAGE = "page"
  KEY_SHOW_ID = "show_id"
  KEY_CHANNEL = "channel"
  KEY_COMPANY_ID = "company_id"

  def build_url(type, parameters)
    url = sprintf(BUILD_URL, type)

    parameters.each do |param_key, param_value|
      url += "&#{param_key}=#{param_value}"
    end

    return url
  end

  def execute_get_for_url(url)
    Rails.logger.info "\n\n --- HULU API ---\n\nHitting url: \n#{url}\n\n"
    source = Net::HTTP.get_response(URI.parse(url))
    Rails.logger.info "EXECUTE_GET_FOR_URL: #{source.code}"
    return [source.code, source.body]
  end

  def get_shows(limit, order_by, total)
    parameters = {KEY_LIMIT => limit,
                  KEY_ORDER_BY => order_by,
                  KEY_TOTAL => total}
    url = build_url(TYPE_SHOWS, parameters)
    return execute_get_for_url(url)
  end

  def get_shows_by_company(company, limit, order_by)
    parameters = {KEY_LIMIT => limit,
                  KEY_ORDER_BY => order_by}
    url = build_url(TYPE_COMPANIES, parameters)
    return execute_get_for_url(url)
  end

  def search(query, items_per_page, page)
    url = sprintf(SEARCH_URL, "Hulu", query, items_per_page, page)
    Rails.logger.info "\n\n --- HULU API SEARCH ---\n\nHitting url: \n#{url}\n\n"
    return execute_get_for_url(url)
  end

  def get_videos_for_show_by_id(show_id, limit, order_by, page, total_only)
    Rails.logger.info "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
    Rails.logger.info "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
    Rails.logger.info "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
    
    Rails.logger.info "get_videos_for_show_by_id page: #{page}"
    parameters = {"order_by" => order_by,
                  "limit" => limit,
                  "show_id" => show_id,
                  "page" => page,
                  "show_id" => show_id,
                  "total" => total_only}
    url = build_url(TYPE_VIDEOS, parameters)

    return execute_get_for_url(url)
  end

end
