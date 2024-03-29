class ChatRoomsController < ApplicationController
  before_action :set_chat_room, only: [:show, :edit, :update, :destroy]

  before_action :require_auth, :only => [:rooms]

  skip_before_action :verify_authenticity_token


  #def test2
  #  head 200, content_type: 'text/html'
  #
  #  # render :json => {:code=>200,:msg => 'ok2'}
  #end

  def rooms
    # respond_to(&:html)
  end


  # GET /chat_rooms
  def index
    # @chat_rooms = ChatRoom.all
  end

  def test1
    data = {}
    data[:data] = {}
    data[:data][:code] = 1000
    data[:data][:msg] = 'ok1'

    render json: data
  end

  def test2
    key = 'Udesk*A8B6C4D2E0Udesk*A8B6C4D2E0'
    payload = params
    payload.delete("chat_room")
    payload.delete("controller")
    payload.delete("action")
    #
    result = JSON.pretty_generate(JSON.parse(payload.to_json)).gsub("\n", "<br>")
    # _ip = request.remote_ip.to_s

    ActionCable.server.broadcast 'chat',
                                 message: "#{result}",
                                 user: 'request',
                                 color: 'blue'


    actual_data = payload['data'] || 'ABFRA3VAdxErbOtCL1fxHkTEkSJqlcJafBaVivlUPGI=\n'
    data = Base64.decode64(actual_data)
    decipher = OpenSSL::Cipher::AES.new(256, :ECB)
    decipher.decrypt
    decipher.key = key
    decipher.padding = 5
    decrypted = decipher.update(data) + decipher.final
    actual_result = decrypted.strip

    #actual_result = JSON.pretty_generate(JSON.parse(payload.to_json)).gsub("\n", "<br>")

    ActionCable.server.broadcast 'chat',
                                 message: "#{actual_result.force_encoding("utf-8")}",
                                 user: 'request_actual_data',
                                 color: 'green'


    data = {}
    data[:data] = {}
    data[:data][:code] = 1000
    data[:data][:msg] = 'ok1'

    cipher = OpenSSL::Cipher::AES.new(256, :ECB)
    cipher.encrypt
    cipher.padding = 5
    cipher.key = key
    encrypted = cipher.update(data[:data].to_json) + cipher.final
    data_encrypted = Base64.encode64(encrypted)
    data[:data] = data_encrypted


    result2 = JSON.pretty_generate(JSON.parse(data.to_json)).gsub("\n", "<br>")
    ActionCable.server.broadcast 'chat',
                                 message: "#{result2}",
                                 user: 'response',
                                 color: 'red'
    render json: data
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
