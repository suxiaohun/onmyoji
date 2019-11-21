class AppVersion < ApplicationRecord
  after_create :notice


  def notice
    ActionCable.server.broadcast 'yys', message: "阴阳师大人\n我刚刚更新了新版本\n请您刷新页面后使用哦."
  end
end
