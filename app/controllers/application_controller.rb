class ApplicationController < ActionController::Base


  protect_from_forgery prepend: true


  # users must auth
  def require_auth
    if cookies[:nick_name]
    	binding.pry
    	Rails.logger.info("====================#{cookies[:nick_name]}==============================")
      true
    else
    	binding.pry
    	Rails.logger.info("---------------------#{cookies[:nick_name]}-----------------------------")
      redirect_to '/auth'
    end
  end

end
