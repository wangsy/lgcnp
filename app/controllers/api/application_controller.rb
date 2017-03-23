class Api::ApplicationController < ActionController::Base
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

  def api_hash_for_user_list(list_of_objs, page: nil, list_key:nil, add_page_info: true)
    list_key = list_key || controller_name
    result = {}
    result[list_key] = list_of_objs.map do |obj|
      if block_given?
        yield(obj)
      else
        obj.try(:to_api_hash_for_yanus)
      end
    end
  end

  def set_header(size)
    response.set_header("Content-length", size)
  end
end
