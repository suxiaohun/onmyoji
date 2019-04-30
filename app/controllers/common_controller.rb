class CommonController < ApplicationController

  before_action :require_auth, :only => [:xiuxian]

  def su
    today = Date.today
    start_day = Date.parse('2019-01-07')
    end_day = Date.parse('2020-01-07')

    @days1 = (end_day - today).to_i
    @days2 = (today - start_day).to_i

    @percent = ((@days2 / 365.0) * 100).round(2)
  end


  def xiuxian
    render :layout => 'xiuxian'
  end



  def novels

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
