class ApplicationController < ActionController::Base


  protect_from_forgery prepend: true


  # users must auth
  def require_auth
    if cookies[:nick_name]
    	 
    	Rails.logger.info("====================#{cookies.size}==============================")
    	Rails.logger.info("====================#{cookies[:nick_name]}==============================")
      true
    else
    	Rails.logger.info("====================#{cookies.size}==============================")
    	Rails.logger.info("---------------------#{cookies[:nick_name]}-----------------------------")
      redirect_to '/auth'
    end
  end

end
