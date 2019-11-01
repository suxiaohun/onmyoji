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

end
