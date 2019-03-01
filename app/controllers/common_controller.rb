class CommonController < ApplicationController

  before_action :require_auth, :only => [:xiuxian]

  def xiuxian
    render :layout => 'xiuxian'
  end


  def index
  end


=begin
  cookies[:name] = {
    value: 'a yummy cookie',
    expires: 1.year,
    domain: 'domain.com'
  }
=end
  def auth

    if request.post?
      cookies[:nick_name] = {value: params[:name], expires: 7.days}
      flash[:nick_name] = params[:name]
      redirect_to '/xiuxian'
    else
      # cookies.delete :nick_name
    end
  end


  # users must auth
  def require_auth
    Rails.logger.info("@@@@@@@@@@@@#{cookies[:nick_name]}@@@@@@@@@@@@@@")

    if cookies[:nick_name]

      # Rails.logger.info("====================#{cookies.size}==============================")
      Rails.logger.info("====================#{cookies[:nick_name]}==============================")
      true
    else
      # Rails.logger.info("====================#{cookies.size}==============================")
      Rails.logger.info("---------------------#{cookies[:nick_name]}-----------------------------")
      redirect_to '/auth'
    end
  end

end
