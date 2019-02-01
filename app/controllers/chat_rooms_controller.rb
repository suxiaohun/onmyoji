class ChatRoomsController < ApplicationController
  before_action :set_chat_room, only: [:show, :edit, :update, :destroy]

  before_action :require_auth, :except => [:auth,:canvas,:su]

  skip_before_action :verify_authenticity_token

  # GET /chat_rooms
  def index
    # @chat_rooms = ChatRoom.all
  end

  def auth

    if request.post?
      # cookies[:name] = {
      #   value: 'a yummy cookie',
      #   expires: 1.year,
      #   domain: 'domain.com'
      # }
      cookies[:nick_name] = {value: params[:name], expires: 7.days}
      redirect_to '/'
    end

  end

  def join
    # _ip = request.env['HTTP_X_FORWARDED_FOR'] || request.remote_ip
    # ips = raw_ip.split(',')
    # ip = ips[0].strip if ips.try(:size) > 0
    # _ip = request.remote_ip

    _ip = request.remote_ip
    ActionCable.server.broadcast 'chat',
                                 message: "#{cookies[:nick_name]}(#{_ip})加入聊天室",
                                 user: '系统',
                                 color: 'blue'

  end

  def leave
    _ip = request.remote_ip
    ActionCable.server.broadcast 'chat',
                                 message: "#{cookies[:nick_name]}(#{_ip})离开聊天室",
                                 user: '系统',
                                 color: 'grey'

  end

  # GET /chat_rooms/1
  def show
  end

  def su
    today = Date.today



    start_day = Date.parse('2019-01-07')
    end_day = Date.parse('2020-01-07')

    @days1 = (end_day - today).to_i
    @days2 = (today - start_day).to_i

    @percent = ((@days2/365.0)*100).round(2)

  end

  def canvas

  end

  # GET /chat_rooms/new
  def new
    @chat_room = ChatRoom.new
  end

  # GET /chat_rooms/1/edit
  def edit

  end

  # POST /chat_rooms
  def create
    @chat_room = ChatRoom.new(chat_room_params)

    if @chat_room.save
      redirect_to @chat_room, notice: 'Chat room was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /chat_rooms/1
  def update
    if @chat_room.update(chat_room_params)
      redirect_to @chat_room, notice: 'Chat room was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /chat_rooms/1
  def destroy
    @chat_room.destroy
    redirect_to chat_rooms_url, notice: 'Chat room was successfully destroyed.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_chat_room
    @chat_room = ChatRoom.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def chat_room_params
    params.require(:chat_room).permit(:name, :remark)
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
