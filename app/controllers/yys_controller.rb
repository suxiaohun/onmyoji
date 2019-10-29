class YysController < ApplicationController
  # protect_from_forgery
  before_action :require_auth, :except => [:auth]

  # layout false

  def yys
    @ssrs = ShiShen.where(mode: 'SSR')
    @sps = ShiShen.where(mode: 'SP')
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
    need_piece_sids = Piece.where(sama: cookies[:nick_name], mode: 'NEED').pluck(:sid)

    @exist_pieces = Piece.where(mode: 'OWN', sid: need_piece_sids).order(sid: :desc, count: :desc)
    @exist_pieces.each do |ep|
      nps = Piece.where(mode: 'NEED', sama: ep.sama)
      data = []
      nps.each do |np|
        data << "#{np.shi_shen.name}（#{np.count}）"
      end
      ep.need_shi_shen_names = data
    end
  end


  def auth
    if request.post?
      cookies[:nick_name] = {value: params[:name], expires: 30.days}
      flash[:nick_name] = params[:name]
      redirect_to '/my_pieces'
    else
      cookies.delete :nick_name
    end
  end

  private

  def require_auth
    if cookies[:nick_name]
      true
    else
      redirect_to '/yys/auth'
    end
  end


end
