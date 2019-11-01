class ApplicationController < ActionController::Base


  # protect_from_forgery prepend: true




  def get_region_key(nick_name)
    region_name = nick_name.split('-')[0]
    Region.find_by(name: region_name).try(:key)
  end
end
