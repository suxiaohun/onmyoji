class ApplicationController < ActionController::Base


  protect_from_forgery prepend: true


  # users must auth
  def require_auth
    if cookies[:nick_name]
      true
    else
      redirect_to '/auth'
    end
  end

end
