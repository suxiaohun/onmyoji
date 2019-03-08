class CommonController < ApplicationController

  before_action :require_auth, :only => [:xiuxian]

  def xiuxian
    render :layout => 'xiuxian'
  end


  def novels

  end



  def index

    @books = Book.all


    render :layout => 'layui'
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


  # users must auth
  def require_auth

    if cookies[:nick_name]
      true
    else
      redirect_to '/auth'
    end
  end

end
