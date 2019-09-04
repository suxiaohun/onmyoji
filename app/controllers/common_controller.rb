class CommonController < ApplicationController

  before_action :require_auth, :only => [:xiuxian]

  def index

  end

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


  def json_format

    render layout: 'sojson'
  end

  def colors

  end

  def md5

    render layout: 'common'
  end

  def sha1

    render layout: 'common'
  end

  def generate_md5
    # call_id=705c0612-a2b6-42e5-94a6-51cbb939f26d&timestamp=20190904142726&d85dc68dfab014ff8cca12dbc356e308
    sign_str = "call_id=#{params[:call_id].to_s}&timestamp=#{params[:timestamp].to_s}&#{params[:secret].to_s}"
    @sign =  Digest::MD5.hexdigest(sign_str)
  end
  def generate_sha1
    sign_str = "#{params[:admin_email].to_s}&#{params[:auth_token].to_s}&#{params[:timestamp].to_s}"
    @sign = Digest::SHA1.hexdigest(sign_str)
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
      redirect_to '/common/auth'
    end
  end

end
