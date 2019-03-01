class CommonController < ApplicationController
  before_action :require_auth, :only => [:xiuxian]

  def xiuxian
    render :layout => 'xiuxian'
  end

  #
  # def index
  #
  #   CrystalMailer.welcome.deliver_later
  #
  #   render :json => {:msg=>11111}
  #
  #
  # end

  def welcome

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
      cookies.delete :nick_name
    end
  end


end
