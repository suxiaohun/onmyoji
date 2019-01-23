module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_verified_user
    end

    private

    # 验证user信息,有两种形式cookie或session
    def find_verified_user
      verified_user = cookies[:nick_name]
      if verified_user
        verified_user
      else
        reject_unauthorized_connection
      end
    end


  end
end
