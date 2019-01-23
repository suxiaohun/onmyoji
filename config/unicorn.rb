module Rails
  class <<self
    def root
      File.expand_path(__FILE__).split('/')[0..-3].join('/')
    end
  end
end

rails_env = "production"

worker_processes 4 # 进程数

working_directory Rails.root  # available in 0.94.0+ 在这里修改为项目所在目录

#listen "/tmp/unicorn_lczg.sock", :backlog => 512

listen 3000, :tcp_nopush => true  # 端口号，NginX需要用到此端口号

timeout 150

pid "#{Rails.root}/tmp/pids/unicorn.pid"    # pid文件的位置，可以自己设置，注意权限

stderr_path "#{Rails.root}/log/unicornerr.log"    # 错误日志的位置，自己设置，注意权限
stdout_path "#{Rails.root}/log/unicornout.log"    # 输出日志的位置，自己设置，注意权限

preload_app true

GC.respond_to?(:copy_on_write_friendly=) and
    GC.copy_on_write_friendly = true
check_client_connection false

# before_fork do |server, worker|
#   defined?(ActiveRecord::Base) and
#       ActiveRecord::Base.connection.disconnect!
# end


before_fork do |server, worker|
  old_pid ="#{Rails.root}/tmp/pids/unicorn.pid.oldbin"
  if File.exists?(old_pid) && server.pid != old_pid
    begin
      Process.kill("QUIT", File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
      puts "Send 'QUIT' signal to unicorn error!"
    end
  end
end


after_fork do |server, worker|
  defined?(ActiveRecord::Base) and
      ActiveRecord::Base.establish_connection
end
