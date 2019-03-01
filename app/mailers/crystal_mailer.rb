class CrystalMailer < ApplicationMailer

  default from: 'notifications@example.com'

  def welcome
    mail(to: 'huxiaoyang@udesk.cn', subject: 'Welcome to My Awesome Site',
         body: '1111',
        content_type: "text/html" )

  end



end
