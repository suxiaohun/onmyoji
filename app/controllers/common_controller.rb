class CommonController < ApplicationController

  before_action :require_auth, :only => [:xiuxian]
  skip_before_action :verify_authenticity_token, :only => [:paas_callback, :oss_check_file_callback]

  def oss_check_file_callback
    email = []
    email << 'huxiaoyang@udesk.cn'

    content = []
    content << "发现违规文件："
    content << "bucket：#{params[:bucket_name] || 'unknown'}"
    content << "路径：#{params[:object_key] || 'unknown'}"

    subject = "oss违规文件告警: " + params[:subject] || 'unknown'
    SonarMailer.send_email(email, content, subject).deliver_now
    render json: {:msg => 'ooooooook'}
  end


  def paas_callback

    # request.parameters
    # 获取原始参数，不用ActionController::Parameters封装
    # 或者过滤之后再进行处理
    if params[:category] == 'call'
      payload = request.parameters[:payload]
      result1 = JSON.pretty_generate(payload)

      Rails.logger.info "========================1======================="
      Rails.logger.info payload.pretty_inspect
      Rails.logger.info result1
      Rails.logger.info "========================2======================="

      result2 = result1.gsub("\n", "<br>")

      user = payload[:workflow] + " => " + payload[:type].ljust(16) + "（#{payload[:call_id]}）" + "（#{Time.now.to_strf}）"

      ActionCable.server.broadcast 'chat',
                                   message: result2 || 'nothing',
                                   # user: "cc_paas(推送)：#{Time.now.to_strf}",
                                   user: user,
                                   color: 'red'
    end


    # result = request.body.rewind

    # Rails.logger.info "================#{result.to_s}"

    # result = JSON.parse(result) rescue false
    #
    # result = JSON.pretty_generate(result).gsub("\n", "<br>") if result

    render :json => {:code => 1000, :msg => 'cc paas ok'}
  end

  def es

  end

  def nga
    url = "http://bbs.nga.cn/thread.php"
    params = {}
    params[:fid] = 7
    params[:page] = 1
    params[:lite] = 'js'

    result = RestClient.get(url, params)
    binding.pry
    #   http://bbs.nga.cn/thread.php?fid=7&page=1&lite=js

  end

  def blank
    render :layout => 'common'
  end

  def index
    # CreateAgentNoticeJob.perform_later
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
    @sign = Digest::MD5.hexdigest(sign_str)
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
