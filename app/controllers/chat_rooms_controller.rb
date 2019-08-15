class ChatRoomsController < ApplicationController
  before_action :set_chat_room, only: [:show, :edit, :update, :destroy]

  before_action :require_auth, :only => [:rooms]

  skip_before_action :verify_authenticity_token


  def test2

    render :json => {:code=>200,:msg => 'ok2'}
  end

  def rooms
    # respond_to(&:html)
  end


  # GET /chat_rooms
  def index
    # @chat_rooms = ChatRoom.all
  end


  def test
    # payload = params
    # payload.delete("chat_room")
    # payload.delete("controller")
    # payload.delete("action")
    #
    # result = JSON.pretty_generate(JSON.parse(payload.to_json)).gsub("\n", "<br>")
    # _ip = request.remote_ip.to_s
    # ActionCable.server.broadcast 'chat',
    #                              message: "#{result}",
    #                              user: "udesk推送(#{_ip})#{Time.now.to_s}",
    #                              color: 'red'

    render :json => {:code=>1000,:msg => 'ok1'}
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

    render :json => {:msg => 'ok'}
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
      redirect_to '/rooms'
    else
      cookies.delete :nick_name
    end
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


  def require_auth
    if cookies[:nick_name]

    else
      redirect_to '/auth'
    end
  end

end
