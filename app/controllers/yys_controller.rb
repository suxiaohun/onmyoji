class YysController < ApplicationController
  # protect_from_forgery
  before_action :require_auth, :except => [:auth]

  # layout false


  def yys
    @ssrs = ShiShen.where(mode: 'SSR')
    @sps = ShiShen.where(mode: 'SP')
  end


  # 1. 神秘的符咒抽到R，SR，SSR阶式神的概率分别为：R卡78.75%，SR卡20%，SP/SSR卡1.25%。
  # 2. 如果开启联动活动，则有25%的概率在使用勾玉，神秘的符咒，现世符咒召唤时获得联动角色碎片。
  # 3.带有SP皮肤的SSR式神，在召唤获得时，有10%的概率同时获得该SP皮肤；若玩家已获得该式神的SP皮肤，则不会重复获取。
  # 4.其中SP式神的总概率上调为固定0.25%，SSR式神的总概率上调为固定1%
  #
  #
  # 注：召唤期内使用神秘的符咒进行召唤时，SP/SSR式神出现概率提升至原来的2.5倍！每位阴阳师大人享受3次SP/SSR概率UP的机会。

  def call
    @result = []
  end

  def summon
    number = params[:number].to_i # 票数
    mode = params[:mode] || false # 是否全图鉴
    up = params[:up] # 是否开启三次up

    spec_up = params[:spec_up]

    if spec_up == 'SP'
      spec_shi_shen = '鬼王酒吞童子'
      sss = ShiShen.where(kind: 'origin').where.not(sid: 341)
      if mode
        spec_rate = 10
      else
        spec_rate = 3
      end
    elsif spec_up == 'SSR'
      spec_shi_shen = '泷夜叉姬'
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
          @result[num + 1] = "<span style='color:#111de0;font-weight:bold;'>#{spec_shi_shen}（700抽保底）</span>"
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
            puts "-----#{num + 1}---#{spec_shi_shen}------------"
            @result[num + 1] = "<span style='color:red;font-weight:bold;'>#{spec_shi_shen}（指定式神概率up：#{spec_rate}%）</span>"
            spec_up = false
          else
            # 从其他卡池中随机挑选一个
            @result[num + 1] = sss[rand sss.size].name
          end
          next
        end

        seed2 = rand(125)
        if seed2 < 100 # ssr
          puts "==========================#{africa_count}=============="
          africa_vote(africa_count, @msg)
          africa_count = 0
          @result[num + 1] = ssrs[rand ssrs.size].name
        else # sp
          africa_count += 1
          @result[num + 1] = sps[rand sps.size].name
        end
      else
        africa_count += 1
      end
    end

    puts "==========================#{africa_count}=============="
    africa_vote(africa_count, @msg)
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
      redirect_to '/my_pieces'
    else
      cookies.delete :nick_name
    end
  end

  private

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
      12
    elsif num >= 400
      11
    elsif num >= 350
      10
    elsif num >= 300
      9
    elsif num >= 250
      8
    elsif num >= 200
      7
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
        redirect_to '/yys/auth'
      end
    else
      redirect_to '/yys/auth'
    end
  end


end
