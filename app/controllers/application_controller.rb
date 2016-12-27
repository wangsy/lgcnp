class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate

  def api_hash_for_list(list_of_objs, page: nil, list_key:nil, add_page_info: true)
    list_key = list_key || controller_name
    result = {}

    result[list_key] = list_of_objs.map do |obj|
      if block_given?
        yield(obj)
      else
        obj.try(:to_api_hash)
      end
    end
  end

  protected
  def authenticate
    Rails.logger.info request.headers['Authorization']
    if request.headers['Authorization'] != "y-QluzhQGWO3zWkTQtw_0w"
      authenticate_token
    end
  end

  def authenticate_token
    authenticate_or_request_with_http_token do |token, options|
      Rails.logger.info "! authenticate"
      Rails.logger.info token
    end
  end
end
