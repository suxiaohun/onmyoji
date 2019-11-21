namespace :app_version do
  desc "发版后,即时通知前端版本变更"
  task update: :environment do
    AppVersion.create(version: Time.now.to_s)
  end

end
