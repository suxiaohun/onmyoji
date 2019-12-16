class TestController < ApplicationController
  skip_before_action :verify_authenticity_token


  def push
    # 设置cookie，以防止channel订阅失败
    cookies[:nick_name] ||= 'anonymous'
  end

  def push_target
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

      ActionCable.server.broadcast 'push',
                                   message: result2 || 'nothing',
                                   # user: "cc_paas(推送)：#{Time.now.to_strf}",
                                   user: user,
                                   color: 'red'
    end
    render json: {msg: "ok"}
  end


  def call_event_push
    payload = params.to_hash
    result1 = JSON.pretty_generate(payload)

    Rails.logger.info "========================1======================="
    Rails.logger.info payload.pretty_inspect
    Rails.logger.info result1
    Rails.logger.info "========================2======================="

    result2 = result1.gsub("\n", "<br>")

    ActionCable.server.broadcast 'push',
                                 message: result2 || 'nothing',
                                 user: "通话事件（#{payload[:occasion]}）推送：#{Time.now.to_strf}",
                                 color: 'red'
  end
end
