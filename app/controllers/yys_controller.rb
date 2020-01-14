class YysController < ApplicationController

  before_action :require_auth, :except => [:auth, :all_cookies]

  def mitama

  end


  def connections
    @connections = ActionCable.server.connections
  end

  def app_version
    AppVersion.create(version: '1')
    # ActionCable.server.broadcast 'yys',{ message: "大人,您好,我刚刚更新了新版本,请您刷新页面后使用哦.1111111"}
    render json: {msg: 'oooooooooo'}
  end

  def index
    config = HashWithIndifferentAccess.new(YAML.load(File.read(File.expand_path('../../../config/property.yml', __FILE__)))).deep_symbolize_keys
    @max_count = config[:max_pick_count] || 1000
  end


  # todo 如果票数大于等于500抽,需要进行统计,分别统计全图\非全图的概率,用redis存储,每小时持久化到db中
  # todo 统计500抽不出货的场景
  # todo 统计700抽才出货的场景
  #def summon
  #  number = params[:number].to_i # 票数
  #  number = 3000 if number > 3000
  #  mode = params[:mode] || false # 是否全图鉴
  #  up = params[:up] # 是否开启三次up
  #
  #  spec_up = params[:spec_up]
  #
  #  rate_flag = mode && up && spec_up && number > 499 # 全图活动计数标志
  #  set_rate_total if rate_flag
  #
  #
  #  if params[:cartoon]
  #    @show_cartoon = true
  #  else
  #    @show_cartoon = false
  #  end
  #
  #  if spec_up == 'SP'
  #    # 天剑韧心鬼切
  #    spec_shi_shen = ShiShen.find_by_sid 343
  #    spec_shi_shen.color = 'rgb(232,112,30)'
  #    sss = ShiShen.where(kind: 'origin').where.not(sid: 343)
  #    if mode
  #      spec_rate = 10
  #    end
  #  elsif spec_up == 'SSR'
  #    # 云外境
  #    spec_shi_shen = ShiShen.find_by_sid 344
  #    spec_shi_shen.color = 'rgb(232,112,30)'
  #    sss = ShiShen.where(kind: 'origin').where.not(sid: 344)
  #    if mode
  #      spec_rate = 15
  #    else
  #      spec_rate = 4
  #    end
  #  else
  #    spec_up = false
  #  end
  #
  #  if up
  #    up_count = 3
  #  else
  #    up_count = 0
  #  end
  #
  #  ssrs = ShiShen.where(mode: 'SSR', kind: 'origin')
  #  sps = ShiShen.where(mode: 'SP', kind: 'origin')
  #
  #  ShiShen.pluck(:sid)
  #
  #  @result = {}
  #  @msg = {}
  #  africa_count = params[:africa_count] || 0
  #
  #  number.times do |num|
  #    if num == 199
  #      europe_common_6(@result)
  #      europe_common_8(@result)
  #    end
  #    # 根据票数提升spec_rate
  #    if spec_up
  #      # 全图700抽保底，如果第700抽时依然没有抽取到指定式神，则直接抽出指定式神
  #      if mode && num == 699
  #        @result[num + 1] = {}
  #        @result[num + 1][:sid] = spec_shi_shen.sid
  #        @result[num + 1][:name] = "<span style='color:#111de0;font-weight:bold;'>#{spec_shi_shen.name}（700抽保底）</span>"
  #        @result[num + 1][:name_sp] = spec_shi_shen.name_sp
  #        @result[num + 1][:cartoon] = spec_shi_shen.cartoon
  #        @result[num + 1][:cartoon_sp] = spec_shi_shen.cartoon_sp
  #        spec_up = false
  #        set_rate_700 if rate_flag
  #        next
  #      end
  #      spec_rate = get_spec_rate(num, spec_up, mode)
  #    end
  #
  #    seed1 = rand * 100
  #    if up_count > 0
  #      pick_rate = 1.25 * (1 + 2.5)
  #    else
  #      pick_rate = 1.25
  #    end
  #    if seed1 < pick_rate
  #      if up_count > 0
  #        up_count -= 1
  #        # 三次up结束时，需要判定"灯鹿就送"
  #        africa_spec_2(@result, num, spec_shi_shen) if up_count == 0
  #      end
  #      # 指定概率提升，仅生效一次
  #      if spec_up
  #        spec_seed = rand(100)
  #        if spec_seed < spec_rate
  #          europe_spec_1(spec_shi_shen) if num == 0
  #          @result[num + 1] = {}
  #          @result[num + 1][:sid] = spec_shi_shen.sid
  #          @result[num + 1][:name] = "<span style='color:#{spec_shi_shen.color};font-weight:bold;'>#{spec_shi_shen.name}（指定概率up：#{spec_rate}%）</span>"
  #          @result[num + 1][:name_sp] = spec_shi_shen.name_sp
  #          @result[num + 1][:cartoon] = spec_shi_shen.cartoon
  #          @result[num + 1][:cartoon_sp] = spec_shi_shen.cartoon_sp
  #          set_rate_500 if rate_flag && num > 499
  #          # 如果是SSR，要重置非酋计数器
  #          if spec_up == 'SSR'
  #            africa_vote(africa_count, @msg)
  #            africa_spec_1 if (num == 499 && africa_count == 499)
  #            africa_count = 0
  #          end
  #          spec_up = false
  #        else
  #          # 从其他卡池中随机挑选一个
  #          rand_ss = sss[rand sss.size]
  #          @result[num + 1] = {}
  #          @result[num + 1][:sid] = rand_ss.sid
  #          @result[num + 1][:name] = rand_ss.name
  #          @result[num + 1][:name_sp] = rand_ss.name_sp
  #          @result[num + 1][:cartoon] = rand_ss.cartoon
  #          @result[num + 1][:cartoon_sp] = rand_ss.cartoon_sp
  #          # 如果是SSR，要重置非酋计数器
  #          if rand_ss.mode == 'SSR'
  #            africa_vote(africa_count, @msg)
  #            africa_spec_1 if (num == 499 && africa_count == 499)
  #            africa_count = 0
  #          end
  #        end
  #        next
  #      end
  #
  #      seed2 = rand(125)
  #      if seed2 < 100 # ssr
  #        ss = ssrs[rand ssrs.size]
  #        africa_vote(africa_count, @msg)
  #        # 如果是小鹿，需要判定高速公鹿成就
  #        africa_spec_4(africa_count) if ss.sid == '259'
  #        africa_count = 0
  #        @result[num + 1] = {}
  #        @result[num + 1][:sid] = ss.sid
  #        @result[num + 1][:name] = ss.name
  #        @result[num + 1][:name_sp] = ss.name_sp
  #        @result[num + 1][:cartoon] = ss.cartoon
  #        @result[num + 1][:cartoon_sp] = ss.cartoon_sp
  #      else # sp
  #        africa_count += 1
  #        ss = sps[rand sps.size]
  #        @result[num + 1] = {}
  #        @result[num + 1][:sid] = ss.sid
  #        @result[num + 1][:name] = ss.name
  #        @result[num + 1][:name_sp] = ss.name_sp
  #        @result[num + 1][:cartoon] = ss.cartoon
  #        @result[num + 1][:cartoon_sp] = ss.cartoon_sp
  #      end
  #      europe_uniq_1(@result[num + 1]) if num == 0
  #      europe_common_1(num + 1)
  #    else
  #      africa_count += 1
  #      africa_spec_1 if (num == 499 && africa_count == 499)
  #    end
  #  end
  #
  #  set_rate_500 if rate_flag && spec_up && number == 500
  #
  #  africa_vote(africa_count, @msg)
  #
  #
  #  @africa_bloodlines = Bloodline.find_by_sql "select name,sum(score) total_score,group_concat(concat(remark,'【',score,'】') separator '\n') remark, group_concat(title) title from bloodlines where mode='AFRICA' group by name order by total_score desc limit 10"
  #  @europe_bloodlines = Bloodline.find_by_sql "select name,sum(score) total_score,group_concat(concat(remark,'【',score,'】') separator '\n') remark, group_concat(title) title from bloodlines where mode='EUROPE' group by name order by total_score desc limit 10"
  #
  #  # 同时判定是否sp版本
  #  @result.each do |k, v|
  #    if v[:cartoon]
  #      _seed_sp = rand(100)
  #      if _seed_sp < 10
  #        if v[:cartoon_sp]
  #          v[:name] = "<span style='color:purple;font-weight:bolder;font-size:20px;'>" + v[:name] + '·' + v[:name_sp] + '</span>'
  #          _v_path = ActionController::Base.helpers.video_path("#{v[:sid]}-1.mp4")
  #        end
  #        # 欧皇判定：海豹·幻
  #        europe_spec_3 if k == 0
  #      end
  #      _v_path = ActionController::Base.helpers.video_path("#{v[:sid]}.mp4") unless _v_path
  #      # 暂时统一替换为sp动画
  #      v[:video_path] = _v_path
  #    end
  #  end
  #
  #  @rate = {}
  #  @rate[:all_count] = RATE_REDIS.llen('all_count')
  #  @rate[:all_500_spec_count] = RATE_REDIS.llen('all_500_spec_count')
  #  @rate[:all_500_spec_rate] = ((@rate[:all_500_spec_count] * 1.00 / @rate[:all_count]) * 100).round(2) if @rate[:all_count] > 0
  #  @rate[:all_700_spec_count] = RATE_REDIS.llen('all_700_spec_count')
  #  @rate[:all_700_spec_rate] = ((@rate[:all_700_spec_count] * 1.00 / @rate[:all_count]) * 100).round(2) if @rate[:all_count] > 0
  #
  #  puts @result
  #end

  def summon
    number = params[:number].to_i # 票数
    number = 3000 if number > 3000
    mode = params[:mode] || false # 是否全图鉴
    up = params[:up] # 是否开启三次up

    spec_up = params[:spec_up]

    rate_flag = mode && up && spec_up && number > 499 # 全图活动计数标志
    set_rate_total if rate_flag


    if params[:cartoon]
      @show_cartoon = true
    else
      @show_cartoon = false
    end

    if spec_up == 'SP'
      # 天剑韧心鬼切
      spec_shi_shen = ShiShen.find_by_sid 343
      spec_shi_shen.color = 'rgb(232,112,30)'
      sss = ShiShen.where(kind: 'origin').where.not(sid: 343)
      if mode
        spec_rate = 10
      end
    elsif spec_up == 'SSR'
      # 鬼童丸
      spec_shi_shen = ShiShen.find_by_sid 345
      spec_shi_shen.color = 'rgb(232,112,30)'
      sss = ShiShen.where(kind: 'origin').where.not(sid: 344)
      if mode
        spec_rate = 15
      else
        spec_rate = 4
      end
    else
      spec_up = false
    end

    if up
      up_count = 3
    else
      up_count = 0
    end

    ssrs = ShiShen.where(mode: 'SSR', kind: 'origin')
    sps = ShiShen.where(mode: 'SP', kind: 'origin')

    ShiShen.pluck(:sid)

    @result = {}
    @msg = {}

    africa_count = params[:africa_count] || 0
    number.times do |num|
      # 根据票数提升spec_rate
      if spec_up
        # 全图700抽保底，如果第700抽时依然没有抽取到指定式神，则直接抽出指定式神
        if mode && num == 699
          @result[num + 1] = {}
          @result[num + 1][:sid] = spec_shi_shen.sid
          @result[num + 1][:name] = "<span style='color:#111de0;font-weight:bold;'>#{spec_shi_shen.name}（700抽保底）</span>"
          @result[num + 1][:name_sp] = spec_shi_shen.name_sp
          @result[num + 1][:cartoon] = spec_shi_shen.cartoon
          @result[num + 1][:cartoon_sp] = spec_shi_shen.cartoon_sp
          spec_up = false
          set_rate_700 if rate_flag
          next
        end
        spec_rate = get_spec_rate(num, spec_up, mode)
      end

      seed1 = rand * 100
      if up_count > 0
        pick_rate = 1.25 * (1 + 2.5)
      else
        pick_rate = 1.25
      end
      if seed1 < pick_rate
        if up_count > 0
          up_count -= 1
        end
        # 指定概率提升，仅生效一次
        if spec_up
          spec_seed = rand(100)
          if spec_seed < spec_rate
            @result[num + 1] = {}
            @result[num + 1][:sid] = spec_shi_shen.sid
            @result[num + 1][:name] = "<span style='color:#{spec_shi_shen.color};font-weight:bold;'>#{spec_shi_shen.name}（指定概率up：#{spec_rate}%）</span>"
            @result[num + 1][:name_sp] = spec_shi_shen.name_sp
            @result[num + 1][:cartoon] = spec_shi_shen.cartoon
            @result[num + 1][:cartoon_sp] = spec_shi_shen.cartoon_sp
            set_rate_500 if rate_flag && num > 499
            # 如果是SSR，要重置非酋计数器
            if spec_up == 'SSR'
              africa_vote(africa_count, @msg)
              africa_count = 0
            end
            spec_up = false
          else
            # 从其他卡池中随机挑选一个
            rand_ss = sss[rand sss.size]
            @result[num + 1] = {}
            @result[num + 1][:sid] = rand_ss.sid
            @result[num + 1][:name] = rand_ss.name
            @result[num + 1][:name_sp] = rand_ss.name_sp
            @result[num + 1][:cartoon] = rand_ss.cartoon
            @result[num + 1][:cartoon_sp] = rand_ss.cartoon_sp
            # 如果是SSR，要重置非酋计数器
            if rand_ss.mode == 'SSR'
              africa_vote(africa_count, @msg)
              africa_count = 0
            end
          end
          next
        end

        seed2 = rand(125)
        if seed2 < 100 # ssr
          ss = ssrs[rand ssrs.size]
          africa_vote(africa_count, @msg)
          africa_count = 0
          @result[num + 1] = {}
          @result[num + 1][:sid] = ss.sid
          @result[num + 1][:name] = ss.name
          @result[num + 1][:name_sp] = ss.name_sp
          @result[num + 1][:cartoon] = ss.cartoon
          @result[num + 1][:cartoon_sp] = ss.cartoon_sp
        else # sp
          africa_count += 1
          ss = sps[rand sps.size]
          @result[num + 1] = {}
          @result[num + 1][:sid] = ss.sid
          @result[num + 1][:name] = ss.name
          @result[num + 1][:name_sp] = ss.name_sp
          @result[num + 1][:cartoon] = ss.cartoon
          @result[num + 1][:cartoon_sp] = ss.cartoon_sp
        end
      else
        africa_count += 1
      end
    end

    set_rate_500 if rate_flag && spec_up && number == 500

    africa_vote(africa_count, @msg)

    # 同时判定是否sp版本
    @result.each do |k, v|
      if Rails.env.production? && v[:cartoon]
        _seed_sp = rand(100)
        if _seed_sp < 10
          if v[:cartoon_sp]
            v[:name] = "<span style='color:purple;font-weight:bolder;font-size:20px;'>" + v[:name] + '·' + v[:name_sp] + '</span>'
            _v_path = ActionController::Base.helpers.video_path("#{v[:sid]}-1.mp4")
          end
        end
        _v_path = ActionController::Base.helpers.video_path("#{v[:sid]}.mp4") unless _v_path
        # 暂时统一替换为sp动画
        v[:video_path] = _v_path
      end
    end

    set_total_count
    @rate = {}
    @rate[:total_count] = RATE_REDIS.llen('total_count')
    @rate[:all_count] = RATE_REDIS.llen('all_count')
    @rate[:all_500_spec_count] = RATE_REDIS.llen('all_500_spec_count')
    @rate[:all_500_spec_rate] = ((@rate[:all_500_spec_count] * 1.00 / @rate[:all_count]) * 100).round(2) if @rate[:all_count] > 0
    @rate[:all_700_spec_count] = RATE_REDIS.llen('all_700_spec_count')
    @rate[:all_700_spec_rate] = ((@rate[:all_700_spec_count] * 1.00 / @rate[:all_count]) * 100).round(2) if @rate[:all_count] > 0

    puts @result
  end

  def all_cookies
    @pss = Piece.select(:sama).distinct(:sama)
  end

  def clean_cookie
    Piece.where(sama: params[:sama]).delete_all
    @pss = Piece.select(:sama).distinct(:sama)
  end

  def all_pieces
    @need_pieces = Piece.where(mode: 'NEED').order(sid: :desc)
    @row_span = Piece.where(mode: 'OWN').group(:sid).count
    @own_pieces = Piece.where(mode: 'OWN').order(sid: :desc)
  end

  def my_pieces
    @need_pieces = Piece.where(sama: cookies[:nick_name], mode: 'NEED')
    @own_pieces = Piece.where(sama: cookies[:nick_name], mode: 'OWN')
  end

  def pieces
    if cookies[:nick_name]
      piece = Piece.where(sid: params[:sid], sama: cookies[:nick_name], mode: params[:mode]).first
      if piece
        piece.update_attribute(:count, params[:count])
      else
        piece = Piece.new
        piece.sid = params[:sid]
        piece.sama = cookies[:nick_name]
        piece.region_key = get_region_key(cookies[:nick_name])
        piece.mode = params[:mode]
        piece.count = params[:count]
        piece.save!
      end
    end
    @need_pieces = Piece.where(sama: cookies[:nick_name], mode: 'NEED')
    @own_pieces = Piece.where(sama: cookies[:nick_name], mode: 'OWN')
  end

  def add_need_pieces

    @count = Piece.where(sama: cookies[:nick_name], mode: 'NEED').count
    render layout: false

  end

  def add_own_pieces
    render layout: false
  end

  def match
    region_key = get_region_key(cookies[:nick_name])
    need_piece_sids = Piece.where(sama: cookies[:nick_name], mode: 'NEED').pluck(:sid)

    @exist_pieces = Piece.where(region_key: region_key, mode: 'OWN', sid: need_piece_sids).order(sid: :desc, count: :desc)
    @exist_pieces.each do |ep|
      nps = Piece.where(mode: 'NEED', sama: ep.sama)
      data = []
      nps.each do |np|
        data << "#{np.shi_shen.name}（#{np.count}）"
      end
      ep.need_shi_shen_names = data
    end

    if need_piece_sids.count == 0
      @msg = '您还未配置您需求的碎片，请点击【管理我的碎片】配置后，再匹配。'
    elsif @exist_pieces.count == 0
      @msg = '很抱歉，未匹配到您需求的碎片记录。'
    else
      @msg = '系统内部错误，请联系【苏筱筱】'
    end


  end


  def auth
    if request.post?

      region_name = Region.where(key: params[:region]).first.try(:name) || 'UNKNOWN'
      cookies[:nick_name] = {value: "#{region_name}-#{params[:name]}", expires: 30.days}
      flash[:nick_name] = params[:name]

      # 将ip与nick_name绑定，如果已经存在，则忽略
      ip = request.remote_ip.to_s
      IpNickName.find_or_create_by(name: cookies[:nick_name], ip: ip)

      if params[:redirect_controller].present? && params[:redirect_action].present?
        redirect_to controller: params[:redirect_controller], action: params[:redirect_action]
      else
        redirect_to '/yys'
      end
    else
      cookies.delete :nick_name
    end
  end

  private

  def set_total_count
    RATE_REDIS.rpush('total_count', 1)
  end

  def set_rate_total
    RATE_REDIS.rpush('all_count', 1)
  end

  def set_rate_500
    RATE_REDIS.rpush('all_500_spec_count', 1)
  end

  def set_rate_700
    RATE_REDIS.rpush('all_500_spec_count', 1)
    RATE_REDIS.rpush('all_700_spec_count', 1)
  end

  # 最大票数没有获得ssr/sp
  def africa_common_1(num)
    if num < 50
      score = 0
    elsif num == 50
      score = 100
    elsif num < 100
      score = 100 + (num - 50) * 10
    elsif num < 150
      score = 600 + (num - 100) * 20
    elsif num < 200
      score = 1600 + (num - 150) * 30
    elsif num < 250
      score = 3100 + (num - 200) * 50
    elsif num < 300
      score = 5600 + (num - 250) * 100
    elsif num < 400
      score = 15600 + (num - 300) * 200
    elsif num < 500
      score = 35600 + (num - 400) * 300
    else
      score = 65600 + (num - 500) * 500 * (1.001 ** (num - 500)).round
    end

    record = Bloodline.find_or_create_by(mode: 'AFRICA', category: 'COMMON', seq: 1, name: cookies[:nick_name])
    if num > record.count
      record.count = num
      record.remark = "通用：#{num}抽没有ssr/sp"
      record.score = score
      record.save
    end
  end


  # 非洲·大阴阳师
  def africa_common_2(num)
    record = Bloodline.find_or_create_by(mode: 'AFRICA', category: 'COMMON', seq: 2, name: cookies[:nick_name])
    record.remark = "通用：解锁非洲·大阴阳师成就"
    record.score = 50000
    record.count = num
    record.save
  end

  # 非洲·大酋长
  def africa_spec_1
    record = Bloodline.find_or_create_by(mode: 'AFRICA', category: 'SPECIAL', seq: 1, name: cookies[:nick_name])
    record.title = '大酋长'
    record.remark = "特殊：前500抽内解锁非洲·大阴阳师成就"
    record.score = 100000
    record.count = num
    record.save
  end

  # 非洲·灯鹿就送 || 欧洲·三次up用完所需要的次数
  def africa_spec_2(result, num, spec_ss = nil)
    current_sids = result.values.map { |x| x[:sid] }
    if (current_sids - ['259', '266']) == []
      record = Bloodline.find_or_create_by(mode: 'AFRICA', category: 'SPECIAL', seq: 2, name: cookies[:nick_name])
      record.title = '登录就送'
      record.remark = "特殊：三次up结束时，只获得了小鹿男和青行灯"
      record.score = 500000
      record.count = num
      record.save
    end

    # 第一个十连完成三次up，并且获得活动式神
    # 特殊欧皇奖励:十连召唤出活动式神，并完成三次up；称号：海豹·真【描述：对欧皇来说，没有什么不可能】
    if spec_ss && num < 10
      if current_sids.include? spec_ss.sid
        record = Bloodline.find_or_create_by(mode: 'EUROPE', category: 'SPECIAL', seq: 2, name: cookies[:nick_name])
        record.title = '海豹·真'
        record.remark = "特殊： 第一个十连召唤出活动式神，并完成三次up；"
        record.score = 500000
        record.count = num
        record.save
      end
    end
  end

  # 非洲·高速公鹿
  def africa_spec_4(africa_count)
    if africa_count == 499
      record = Bloodline.find_or_create_by(mode: 'AFRICA', category: 'SPECIAL', seq: 4, name: cookies[:nick_name])
      record.title = '高速公路'
      record.remark = "特殊：只差一票达成非洲·大阴阳师，被小鹿男撞断。"
      record.score = 500000
      record.count = africa_count
      record.save
    end
  end

  def europe_spec_3
    record = Bloodline.find_or_create_by(mode: 'EUROPE', category: 'UNIQUE', seq: 3, uniq_flag: ss[:sid])
    record.name = cookies[:nick_name] if record.name.blank?
    record.title = '海豹·幻'
    record.remark = "唯一：第一个使用第一票召唤出式神-#{ss[:name]}，且获得sp皮肤（#{Date.today}）"
    record.score = 100000
    record.save!
  end


  # 最小票数获得ssr/sp
  def europe_common_1(num)
    if num == 1
      score = 80000
    elsif num == 2
      score = 40000
    elsif num == 3
      score = 20000
    elsif num < 20
      score = 13000 + (20 - num) * 500
    elsif num < 30
      score = 11000 + (30 - num) * 200
    elsif num < 50
      score = 6100 + (50 - num) * 100
    elsif num < 100
      score = 1001 + (100 - num) * 20
    elsif num < 200
      score = 1 + (200 - num) * 10
    elsif num == 200
      score = 1
    else
      score = 0
    end
    return unless score > 0
    record = Bloodline.find_or_create_by(mode: 'EUROPE', category: 'COMMON', seq: 1, name: cookies[:nick_name])
    if record.count == 0 || (record.count >= num)
      record.count = num
      record.remark = "通用：第#{num}抽抽到ssr/sp"
      record.score = score
      record.save
    end
  end

  # 最小票数完成三次up
  def europe_common_2(num)
    if num == 3
      score = 500000
    elsif num == 4
      score = 200000
    elsif num == 5
      score = 100000
    elsif num < 20
      score = 13000 + (20 - num) * 500
    elsif num < 30
      score = 11000 + (30 - num) * 200
    elsif num < 50
      score = 6100 + (50 - num) * 100
    elsif num < 100
      score = 1001 + (100 - num) * 20
    elsif num < 200
      score = 1 + (200 - num) * 10
    elsif num == 200
      score = 1
    else
      score = 0
    end

    record = Bloodline.find_or_create_by(mode: 'EUROPE', spec: 'SPEC2', name: cookies[:name])

    record.count = num
    record.score = score
    record.save
  end

  # 最小票数召唤出ssr（全图）
  def europe_common_3(num)
    if num == 3
      score = 500000
    elsif num == 4
      score = 200000
    elsif num == 5
      score = 100000
    elsif num < 20
      score = 13000 + (20 - num) * 500
    elsif num < 30
      score = 11000 + (30 - num) * 200
    elsif num < 50
      score = 6100 + (50 - num) * 100
    elsif num < 100
      score = 1001 + (100 - num) * 20
    elsif num < 200
      score = 1 + (200 - num) * 10
    elsif num == 200
      score = 1
    else
      score = 0
    end

    record = Bloodline.find_or_create_by(mode: 'EUROPE', spec: 'SPEC3', name: cookies[:name])

    record.count = num
    record.score = score
    record.save
  end

  # 最小票数召唤出ssr（非全图）
  def europe_common_4(num)
    if num == 3
      score = 500000
    elsif num == 4
      score = 200000
    elsif num == 5
      score = 100000
    elsif num < 20
      score = 13000 + (20 - num) * 500
    elsif num < 30
      score = 11000 + (30 - num) * 200
    elsif num < 50
      score = 6100 + (50 - num) * 100
    elsif num < 100
      score = 1001 + (100 - num) * 20
    elsif num < 200
      score = 1 + (200 - num) * 10
    elsif num == 200
      score = 1
    else
      score = 0
    end

    record = Bloodline.find_or_create_by(mode: 'EUROPE', spec: 'SPEC4', name: cookies[:name])

    record.count = num
    record.score = score
    record.save
  end

  # 每10抽获取ssr/sp数量
  def europe_common_5(num)
    if num == 3
      score = 500000
    elsif num == 4
      score = 200000
    elsif num == 5
      score = 100000
    elsif num < 20
      score = 13000 + (20 - num) * 500
    elsif num < 30
      score = 11000 + (30 - num) * 200
    elsif num < 50
      score = 6100 + (50 - num) * 100
    elsif num < 100
      score = 1001 + (100 - num) * 20
    elsif num < 200
      score = 1 + (200 - num) * 10
    elsif num == 200
      score = 1
    else
      score = 0
    end

    record = Bloodline.find_or_create_by(mode: 'EUROPE', spec: 'SPEC5', name: cookies[:name])

    record.count = num
    record.score = score
    record.save
  end

  # 前200抽获取的同名ssr/sp数量
  def europe_common_6(result)
    count = result.size
    return unless count > 0

    values = result.values.map { |x| x[:sid] }
    h = Hash.new(0)
    values.each { |v| h[v] += 1 }

    max_count = h.values.max

    if max_count == 1
      return
    elsif max_count == 2
      score = 5000
    elsif max_count == 3
      score = 13000
    elsif max_count == 4
      score = 40000
    elsif max_count == 5
      score = 80000
    elsif max_count == 6
      score = 160000
    elsif max_count == 7
      score = 400000
    else
      score = 500000 + 10000 * (max_count - 7)
    end
    record = Bloodline.find_or_create_by(mode: 'EUROPE', category: 'COMMON', seq: 6, name: cookies[:nick_name])
    if record.count < max_count
      record.remark = "通用：200抽内获得#{max_count}个同名ssr/sp"
      record.count = max_count
      record.score = score
      record.save!
    end
  end

  # 最小票数抽取到活动式神，并完成非洲大阴阳师成就
  def europe_common_7(num)
    if num == 3
      score = 500000
    elsif num == 4
      score = 200000
    elsif num == 5
      score = 100000
    elsif num < 20
      score = 13000 + (20 - num) * 500
    elsif num < 30
      score = 11000 + (30 - num) * 200
    elsif num < 50
      score = 6100 + (50 - num) * 100
    elsif num < 100
      score = 1001 + (100 - num) * 20
    elsif num < 200
      score = 1 + (200 - num) * 10
    elsif num == 200
      score = 1
    else
      score = 0
    end

    record = Bloodline.find_or_create_by(mode: 'EUROPE', spec: 'SPEC5', name: cookies[:name])

    record.count = num
    record.score = score
    record.save
  end

  # 前200抽获得的ssr/sp数量
  def europe_common_8(result)
    count = result.size
    return unless count > 0
    if count == 1
      score = 10
    elsif count == 2
      score = 100
    elsif count == 3
      score = 500
    elsif count == 4
      score = 1500
    elsif count == 5
      score = 3000
    elsif count == 6
      score = 5000
    elsif count == 7
      score = 8000
    elsif count == 8
      score = 12800
    elsif count == 9
      score = 19000
    elsif count == 10
      score = 30000
    elsif count == 11
      score = 50000
    elsif count == 12
      score = 100000
    else
      score = 100000 + ((count -12) * 50000 * 1.01 ** (count -12)).round
    end
    record = Bloodline.find_or_create_by(mode: 'EUROPE', category: 'COMMON', seq: 8, name: cookies[:nick_name])
    record.remark = "通用：200抽内获得#{count}个ssr/sp"
    if record.count < count
      record.score = score
      record.count = count
      record.save!
    end
  end

  # 最小票数获得一个式神的ssr/sp阶；双重判定，结对数量
  def europe_common_9(num, result)
    values = result.values
    sp_arr = ["315", "322", "326", "327", "328", "331", "334", "339", "341"]
    sp_hash = [
        {"315" => "217"},
        {"322" => "265"},
        {"326" => "304"},
        {"327" => "272"},
        {"328" => "269"},
        # {"331"=>""},# 般若，暂时忽略
        {"334" => "248"},
        {"339" => "300"},
        {"341" => "219"}
    ]
  end

  # 特殊欧皇奖励:第一票召唤出活动式神；称号：每日一抽
  def europe_spec_1(ss)
    record = Bloodline.find_or_create_by(mode: 'EUROPE', category: 'SPECIAL', seq: 1, name: cookies[:nick_name], uniq_flag: ss[:sid])
    record.title = '每日一抽'
    record.remark = "特殊：每日一抽召唤出活动式神-#{ss.name}（#{Date.today}）"
    record.score = 100000
    record.save
  end

  # 特殊欧皇奖励:十连召唤出10个ssr/sp；称号：欧皇·真、欧皇·虚、欧皇·幻
  def europe_spec_spec_ten1(num)
    if num == 3
      score = 500000
    elsif num == 4
      score = 200000
    elsif num == 5
      score = 100000
    elsif num < 20
      score = 13000 + (20 - num) * 500
    elsif num < 30
      score = 11000 + (30 - num) * 200
    elsif num < 50
      score = 6100 + (50 - num) * 100
    elsif num < 100
      score = 1001 + (100 - num) * 20
    elsif num < 200
      score = 1 + (200 - num) * 10
    elsif num == 200
      score = 1
    else
      score = 0
    end

    record = Bloodline.find_or_create_by(mode: 'EUROPE', spec: 'SPEC5', name: cookies[:name])

    record.count = num
    record.score = score
    record.save
  end

  # 特殊欧皇奖励:十连召唤出活动式神，并完成三次up；称号：天选之人【描述：对欧皇来说，没有什么不可能】
  def europe_spec_spec_ten2(num)
    if num == 3
      score = 500000
    elsif num == 4
      score = 200000
    elsif num == 5
      score = 100000
    elsif num < 20
      score = 13000 + (20 - num) * 500
    elsif num < 30
      score = 11000 + (30 - num) * 200
    elsif num < 50
      score = 6100 + (50 - num) * 100
    elsif num < 100
      score = 1001 + (100 - num) * 20
    elsif num < 200
      score = 1 + (200 - num) * 10
    elsif num == 200
      score = 1
    else
      score = 0
    end

    record = Bloodline.find_or_create_by(mode: 'EUROPE', spec: 'SPEC5', name: cookies[:name])

    record.count = num
    record.score = score
    record.save
  end

  # 唯一欧皇奖励：第一个使用第一票召唤出对应式神；称号：海豹·虚
  def europe_uniq_1(ss)
    record = Bloodline.find_or_create_by(mode: 'EUROPE', category: 'UNIQUE', seq: 1, uniq_flag: ss[:sid])
    record.name = cookies[:nick_name] if record.name.blank?
    record.title = '海豹·虚'
    record.remark = "唯一：第一个使用第一票召唤出式神-#{ss[:name]}（#{Date.today}）"
    record.score = 20000
    record.save!
  end


  def all_sp_rate(num)
    if num >= 500
      100
    elsif num >= 450
      80
    elsif num >= 400
      60
    elsif num >= 350
      45
    elsif num >= 300
      40
    elsif num >= 250
      35
    elsif num >= 200
      30
    elsif num >= 150
      25
    elsif num >= 100
      20
    elsif num >= 50
      15
    else
      10
    end
  end

  def all_ssr_rate(num)
    if num >= 500
      100
    elsif num >= 450
      90
    elsif num >= 400
      80
    elsif num >= 350
      60
    elsif num >= 300
      45
    elsif num >= 250
      40
    elsif num >= 200
      35
    elsif num >= 150
      30
    elsif num >= 100
      25
    elsif num >= 50
      20
    else
      15
    end
  end

  def single_sp_rate(num)
    if num >= 700
      25
    elsif num >= 500
      15
    elsif num >= 450
      14
    elsif num >= 400
      13
    elsif num >= 350
      12
    elsif num >= 300
      11
    elsif num >= 250
      10
    elsif num >= 200
      8
    elsif num >= 150
      6
    elsif num >= 100
      5
    elsif num >= 50
      4
    else
      3
    end
  end

  def single_ssr_rate(num)
    if num >= 700
      35
    elsif num >= 500
      20
    elsif num >= 450
      13
    elsif num >= 400
      12
    elsif num >= 350
      11
    elsif num >= 300
      10
    elsif num >= 250
      9
    elsif num >= 200
      8
    elsif num >= 150
      7
    elsif num >= 100
      6
    elsif num >= 50
      5
    else
      4
    end
  end


  def get_spec_rate(num, type, mode)
    # 全图、SP
    if mode && type == 'SP'
      return all_sp_rate(num)
    end
    # 全图、SSR
    if mode && type == 'SSR'
      return all_ssr_rate(num)
    end
    # 非全图、SP
    if !mode && type == 'SP'
      return single_sp_rate(num)
    end
    # 非全图、SSR
    if !mode && type == 'SSR'
      return single_ssr_rate(num)
    end
  end

  def africa_vote(africa_count, arr)
    # 获取最后10条
    records = Bloodline.find_by_sql "select name,max(count) count from bloodlines where mode='AFRICA' and category='COMMON' and seq=1 group by name order by count desc limit 10"
    _count = records.last.try(:count) || 0
    if africa_count > _count
      Bloodline.where(mode: 'AFRICA', category: 'COMMON', seq: 1).where("count < #{_count}").delete_all
      africa_common_1(africa_count)
      africa_common_2(africa_count) if africa_count > 499
    end

    if africa_count > 99
      arr[100] ||= '您解锁了【初级·非酋】成就！'
    end
    if africa_count > 199
      arr[200] ||= '您解锁了【中级·非酋】成就！'
    end
    if africa_count > 299
      arr[300] ||= '您解锁了【高级·非酋】成就！'
    end
    if africa_count > 399
      arr[400] ||= '您解锁了【非洲·阴阳师】成就！'
    end
    if africa_count > 499
      arr[500] ||= '您解锁了【非洲·大·阴阳师】成就！'
    end
  end

  def require_auth

    if cookies[:nick_name]
      region_name = cookies[:nick_name].split('-')[0]
      exist_region = Region.find_by(name: region_name)
      if exist_region
        true
      else
        cookies.delete :nick_name
        redirect_to '/yys/auth'
      end
    else
      redirect_to "/yys/auth?redirect_controller=#{params[:controller]}&redirect_action=#{params[:action]}"
    end
  end


end
