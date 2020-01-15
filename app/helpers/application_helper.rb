module ApplicationHelper

  # 两种下拉选是互斥的
  def shi_shen_need_droplist
    exist_sids = Piece.where(sama: cookies[:nick_name], mode: 'OWN').pluck(:sid)
    ShiShen.where.not(sid: exist_sids).order(sid: :desc).pluck(:name, :sid)
  end

  def shi_shen_own_droplist
    exist_sids = Piece.where(sama: cookies[:nick_name], mode: 'NEED').pluck(:sid)
    ShiShen.where.not(sid: exist_sids).order(sid: :desc).pluck(:name, :sid)
  end

  # 大区下拉选
  def region_drop_list
    Region.order(:id).pluck(:name, :key)
  end

  # 图鉴列表，不包含最新活动式神、联动式神
  def card_shi_shen_list
    spec_shi_shen_id = SPEC_SID

    list = []
    card_list = Card.find_by(nick_name: cookies[:nick_name]).try(:sids) || []

    if card_list.count > 0
      ShiShen.where(kind: 'origin').where.not(sid: spec_shi_shen_id).order(sid: :desc).each do |x|
        if card_list.include? x.sid
          x.owned = true
        else
          x.owned = false
        end
        list << x
      end
    else
      ShiShen.where(kind: 'origin').where.not(sid: spec_shi_shen_id).order(sid: :desc).each do |x|
        x.owned = true
        list << x
      end
    end
  end

end
