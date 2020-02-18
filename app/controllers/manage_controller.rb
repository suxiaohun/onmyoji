class ManageController < ApplicationController

  before_action :require_login, except: [:login]

  def login
    if request.post?
      unless params[:user_name] == 'suxiaohun' && params[:password] == '123456'
        session[:admin] = true
        redirect_to action: 'index'
      end
    end
  end

  def index
    @tips = YysTip.all

  end

  def save_tip
    obj = YysTip.new
    obj.content = params[:content]
    obj.save!
    @tips = YysTip.all
  end

  def edit_tip

  end

  def update_tip

  end

  def destroy_tip
    obj = YysTip.find(params[:id])
    obj.destroy!

    @tips = YysTip.all

  end

  private

  def require_login
    unless session[:admin].present?
      redirect_to 'login'
    end
  end
end
