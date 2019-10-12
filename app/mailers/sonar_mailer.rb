class SonarMailer < ApplicationMailer

  default :from => "sonar<xuyiwen@udesk.cn>"
  # default :from => "lcwg<wgy@example.com>"

  def send_email(email,content,subject='oss发现违规文件')
    @info = content
    mail(to: email, subject: subject)
  end


  def send_email_ruby(email,content,subject='sonar code issues')
    @info = content
    mail(to: email, subject: subject)
  end

end
