class Yys2Controller < ApplicationController

  before_action :require_auth, :except => [:auth, :all_cookies]


  # 抽卡主页
  def index
    config = HashWithIndifferentAccess.new(YAML.load(File.read(File.expand_path('../../../config/property.yml', __FILE__)))).deep_symbolize_keys
    @max_count = config[:max_pick_count] || 1000
  end


  def index3
    config = HashWithIndifferentAccess.new(YAML.load(File.read(File.expand_path('../../../config/property.yml', __FILE__)))).deep_symbolize_keys
    @max_count = config[:max_pick_count] || 1000
  end


  # 添加抽卡动画选项
  # 以10抽为单位，给出提示
  def summon3
    number = params[:number].to_i # 票数
    mode = params[:mode] || false # 是否全图鉴
    up = params[:up] # 是否开启三次up

    spec_up = params[:spec_up]

    if params[:cartoon]
      @show_cartoon = true
    else
      @show_cartoon = false
    end

    if spec_up == 'SP'
      # 鬼王酒吞童子
      spec_shi_shen = ShiShen.find_by_sid 341
      spec_shi_shen.color = 'rgb(232,112,30)'
      sss = ShiShen.where(kind: 'origin').where.not(sid: 341)
      if mode
        spec_rate = 10
      else
        spec_rate = 3
      end
    elsif spec_up == 'SSR'
      # 泷夜叉姬
      spec_shi_shen = ShiShen.find_by_sid 338
      spec_shi_shen.color = 'rgb(248,45,58)'
      sss = ShiShen.where(kind: 'origin').where.not(sid: 338)
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

    puts "==================up_count: #{up_count}==="

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
          @result[num + 1][:cartoon] = spec_shi_shen.cartoon
          spec_up = false
          next
        end
        spec_rate = get_spec_rate(num, spec_up, mode)
        puts "------------up_rate--#{spec_rate}----"
      end

      seed1 = rand * 100
      if up_count > 0
        pick_rate = 1.25 * (1 + 2.5)
      else
        pick_rate = 1.25
      end
      if seed1 < pick_rate
        up_count -= 1 if up_count > 0
        # 指定概率提升，仅生效一次
        if spec_up
          spec_seed = rand(100)
          if spec_seed < spec_rate
            europe_spec_1(spec_shi_shen) if num == 0
            puts "-----#{num + 1}---#{spec_shi_shen.name}------------"
            @result[num + 1] = {}
            @result[num + 1][:sid] = spec_shi_shen.sid
            @result[num + 1][:name] = "<span style='color:#{spec_shi_shen.color};font-weight:bold;'>#{spec_shi_shen.name}（指定式神概率up：#{spec_rate}%）</span>"
            @result[num + 1][:cartoon] = spec_shi_shen.cartoon
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
            @result[num + 1][:cartoon] = rand_ss.cartoon
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
          puts "==========================#{africa_count}=============="
          africa_vote(africa_count, @msg)
          africa_count = 0
          ss = ssrs[rand ssrs.size]
          @result[num + 1] = {}
          @result[num + 1][:sid] = ss.sid
          @result[num + 1][:name] = ss.name
          @result[num + 1][:cartoon] = ss.cartoon
        else # sp
          africa_count += 1
          ss = sps[rand sps.size]
          @result[num + 1] = {}
          @result[num + 1][:sid] = ss.sid
          @result[num + 1][:name] = ss.name
          @result[num + 1][:cartoon] = ss.cartoon
        end
        europe_uniq_1(@result[num + 1]) if num == 0
        europe_common_1(num + 1)
      else
        africa_count += 1
      end
    end

    puts "==========================#{africa_count}=============="
    africa_vote(africa_count, @msg)

    # 加入排行榜
    # 最大抽出SSR/SP次数作为非洲血统排行榜，最多5条
    #
    # todo 欧皇排行榜（分数加权）
    # 指标1：前50抽获得ssr/sp
    #  1.1：50抽=>1分（+1）
    #       。。。
    #       40抽=>10分（+2）
    #       。。。
    #       30抽=>30分（+3）
    #       。。。
    #       20抽=>60分（+5）
    #       。。。
    #       10抽=>110分（+8）
    #       。。。
    #       2抽=>190分
    #       1抽=>200分
    #
    # 指标2：前50抽完成三次up
    #  2.1：
    #
    #
    #
    @africa_bloodlines = Bloodline.find_by_sql "select name,sum(score) total_score,group_concat(remark) remark from bloodlines where mode='AFRICA' group by name order by total_score desc limit 10"
    @europe_bloodlines = Bloodline.find_by_sql "select name,sum(score) total_score,group_concat(concat(remark,'【',score,'】') separator '\n') remark, group_concat(title) title from bloodlines where mode='EUROPE' group by name order by total_score desc limit 10"

    @result.each do |k, v|
      if v[:cartoon]
        _v_path = ActionController::Base.helpers.video_path("#{v[:sid]}.mp4")
        puts "==================//========#{_v_path}=============="
        v[:video_path] = _v_path
      end
    end
    puts @result
  end

  # 抽卡主页-文字版
  def index2
    config = HashWithIndifferentAccess.new(YAML.load(File.read(File.expand_path('../../../config/property.yml', __FILE__)))).deep_symbolize_keys
    @max_count = config[:max_pick_count] || 1000
  end


  def summon2
    number = params[:number].to_i # 票数
    mode = params[:mode] || false # 是否全图鉴
    up = params[:up] # 是否开启三次up

    spec_up = params[:spec_up]

    if spec_up == 'SP'
      # 鬼王酒吞童子
      spec_shi_shen = ShiShen.find_by_sid 341
      spec_shi_shen.color = 'rgb(232,112,30)'
      sss = ShiShen.where(kind: 'origin').where.not(sid: 341)
      if mode
        spec_rate = 10
      else
        spec_rate = 3
      end
    elsif spec_up == 'SSR'
      # 泷夜叉姬
      spec_shi_shen = ShiShen.find_by_sid 338
      spec_shi_shen.color = 'rgb(248,45,58)'
      sss = ShiShen.where(kind: 'origin').where.not(sid: 338)
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

    puts "==================up_count: #{up_count}==="

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
          @result[num + 1][:cartoon] = spec_shi_shen.cartoon
          spec_up = false
          next
        end
        spec_rate = get_spec_rate(num, spec_up, mode)
        puts "------------up_rate--#{spec_rate}----"
      end

      seed1 = rand * 100
      if up_count > 0
        pick_rate = 1.25 * (1 + 2.5)
      else
        pick_rate = 1.25
      end
      if seed1 < pick_rate
        up_count -= 1 if up_count > 0
        # 指定概率提升，仅生效一次
        if spec_up
          spec_seed = rand(100)
          if spec_seed < spec_rate
            puts "-----#{num + 1}---#{spec_shi_shen.name}------------"
            @result[num + 1] = {}
            @result[num + 1][:sid] = spec_shi_shen.sid
            @result[num + 1][:name] = "<span style='color:#{spec_shi_shen.color};font-weight:bold;'>#{spec_shi_shen.name}（指定式神概率up：#{spec_rate}%）</span>"
            @result[num + 1][:cartoon] = spec_shi_shen.cartoon
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
            @result[num + 1][:cartoon] = rand_ss.cartoon
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
          puts "==========================#{africa_count}=============="
          africa_vote(africa_count, @msg)
          africa_count = 0
          ss = ssrs[rand ssrs.size]
          @result[num + 1] = {}
          @result[num + 1][:sid] = ss.sid
          @result[num + 1][:name] = ss.name
          @result[num + 1][:cartoon] = ss.cartoon
        else # sp
          africa_count += 1
          ss = sps[rand sps.size]
          @result[num + 1] = {}
          @result[num + 1][:sid] = ss.sid
          @result[num + 1][:name] = ss.name
          @result[num + 1][:cartoon] = ss.cartoon
        end
      else
        africa_count += 1
      end
    end

    puts "==========================#{africa_count}=============="
    africa_vote(africa_count, @msg)

    # 加入排行榜
    # 最大抽出SSR/SP次数作为非洲血统排行榜，最多5条

    # todo 欧皇排行榜
    @bloodlines = Bloodline.find_by_sql "select name,max(count) count from bloodlines group by name order by count desc limit 10"

    @result.each do |k, v|
      if v[:cartoon]
        _v_path = ActionController::Base.helpers.video_path("#{v[:sid]}.mp4")
        puts "==================//========#{_v_path}=============="
        v[:video_path] = _v_path
      end
    end
    puts @result
  end


  def summon
    number = params[:number].to_i # 票数
    mode = params[:mode] || false # 是否全图鉴
    up = params[:up] # 是否开启三次up

    spec_up = params[:spec_up]

    if spec_up == 'SP'
      # 鬼王酒吞童子
      spec_shi_shen = ShiShen.find_by_sid 341
      spec_shi_shen.color = 'rgb(232,112,30)'
      sss = ShiShen.where(kind: 'origin').where.not(sid: 341)
      if mode
        spec_rate = 10
      else
        spec_rate = 3
      end
    elsif spec_up == 'SSR'
      # 泷夜叉姬
      spec_shi_shen = ShiShen.find_by_sid 338
      spec_shi_shen.color = 'rgb(248,45,58)'
      sss = ShiShen.where(kind: 'origin').where.not(sid: 338)
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

    puts "==================up_count: #{up_count}==="

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
          @result[num + 1][:cartoon] = spec_shi_shen.cartoon
          spec_up = false
          next
        end
        spec_rate = get_spec_rate(num, spec_up, mode)
        puts "------------up_rate--#{spec_rate}----"
      end

      seed1 = rand * 100
      if up_count > 0
        pick_rate = 1.25 * (1 + 2.5)
      else
        pick_rate = 1.25
      end
      if seed1 < pick_rate
        up_count -= 1 if up_count > 0
        # 指定概率提升，仅生效一次
        if spec_up
          spec_seed = rand(100)
          if spec_seed < spec_rate
            puts "-----#{num + 1}---#{spec_shi_shen.name}------------"
            @result[num + 1] = {}
            @result[num + 1][:sid] = spec_shi_shen.sid
            @result[num + 1][:name] = "<span style='color:#{spec_shi_shen.color};font-weight:bold;'>#{spec_shi_shen.name}（指定式神概率up：#{spec_rate}%）</span>"
            @result[num + 1][:cartoon] = spec_shi_shen.cartoon
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
            @result[num + 1][:cartoon] = rand_ss.cartoon
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
          puts "==========================#{africa_count}=============="
          africa_vote(africa_count, @msg)
          africa_count = 0
          ss = ssrs[rand ssrs.size]
          @result[num + 1] = {}
          @result[num + 1][:sid] = ss.sid
          @result[num + 1][:name] = ss.name
          @result[num + 1][:cartoon] = ss.cartoon
        else # sp
          africa_count += 1
          ss = sps[rand sps.size]
          @result[num + 1] = {}
          @result[num + 1][:sid] = ss.sid
          @result[num + 1][:name] = ss.name
          @result[num + 1][:cartoon] = ss.cartoon
        end
      else
        africa_count += 1
      end
    end

    puts "==========================#{africa_count}=============="
    africa_vote(africa_count, @msg)

    # 加入排行榜
    # 最大抽出SSR/SP次数作为非洲血统排行榜，最多5条

    # todo 欧皇排行榜
    @bloodlines = Bloodline.find_by_sql "select name,max(count) count from bloodlines group by name order by count desc limit 10"

    @result.each do |k, v|
      if v[:cartoon]
        _v_path = ActionController::Base.helpers.video_path("#{v[:sid]}.mp4")
        puts "==================//========#{_v_path}=============="
        v[:video_path] = _v_path
      end
    end
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

      if params[:redirect_controller].present? && params[:redirect_action].present?
        redirect_to controller: params[:redirect_controller], action: params[:redirect_action]
      else
        redirect_to '/my_pieces'
      end
    else
      cookies.delete :nick_name
    end
  end

  private

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

  # 最小票数获得ssr/sp
  def europe_common_1(num)
    if num == 1
      score = 500000
    elsif num == 2
      score = 200000
    elsif num == 3
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

    record = Bloodline.find_or_create_by(mode: 'EUROPE', category: 'COMMON', seq: 1, name: cookies[:nick_name])
    puts record.to_json
    if record.count == 0 || (record.count > num)
      puts "================europe---common1========="
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
  def europe_common_6(num)
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
  def europe_common_8(num)
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

  # 最小票数获得一个式神的ssr/sp阶；双重判定，结对数量
  def europe_common_9(num)
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

  # 唯一欧皇奖励：第一个使用第一票召唤出对应式神；称号：一骑绝尘
  def europe_uniq_1(ss)
    record = Bloodline.find_or_create_by(mode: 'EUROPE', category: 'UNIQUE', seq: 1, uniq_flag: ss[:sid])
    record.name = cookies[:nick_name] if record.name.blank?
    record.title = '一骑绝尘'
    record.remark = "唯一：第一个使用第一票召唤出式神-#{ss[:name]}（#{Date.today}）"
    record.score = 50000
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
    end

    if africa_count > 99
      arr[100] ||= '您已经达成了【初级·非酋】成就！'
    end
    if africa_count > 199
      arr[200] ||= '您已经达成了【中级·非酋】成就！'
    end
    if africa_count > 299
      arr[300] ||= '您已经达成了【高级·非酋】成就！'
    end
    if africa_count > 399
      arr[400] ||= '您已经达成了【非洲·阴阳师】成就！'
    end
    if africa_count > 499
      arr[500] ||= '您已经达成了【非洲·大·阴阳师】成就！'
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
        redirect_to '/yys2/auth'
      end
    else
      redirect_to "/yys2/auth?redirect_controller=#{params[:controller]}&redirect_action=#{params[:action]}"
    end
  end


end
