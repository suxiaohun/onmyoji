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



# http://unicorn.bogomips.org/Unicorn/Configurator.html#method-i-before_exec
before_exec do |server|
  ENV['BUNDLE_GEMFILE'] ||= "#{Rails.root}/Gemfile"
end

before_fork do |server, worker|
  defined?(ActiveRecord::Base) and
      ActiveRecord::Base.connection.disconnect!

  old_pid = "#{server.config[:pid]}.oldbin"
  if old_pid != server.pid
    begin
      sig = (worker.nr + 1) >= server.worker_processes ? :QUIT : :TTOU
      Process.kill(sig, File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
      puts "Send 'QUIT' signal to unicorn error!"
    end
  end

  sleep 1
end

after_fork do |server, worker|
  worker_address = "127.0.0.1:#{master_port + worker.nr + 1}"
  server.listen(worker_address, tries: -1, delay: 5, tcp_nopush: true)

  worker_pid = server.config[:pid].sub('.pid', ".#{worker.nr}.pid")
  system "echo #{Process.pid} > #{worker_pid}"

  defined?(ActiveRecord::Base) and
      ActiveRecord::Base.establish_connection
end





# before_exec { |server| ENV["BUNDLE_GEMFILE"] = "#{Rails.root}/Gemfile" }
#
# # before_fork do |server, worker|
# #   defined?(ActiveRecord::Base) and
# #       ActiveRecord::Base.connection.disconnect!
# # end
#
# #
# before_fork do |server, worker|
#   old_pid ="#{Rails.root}/tmp/pids/unicorn.pid.oldbin"
#   if File.exists?(old_pid) && server.pid != old_pid
#     begin
#       Process.kill("QUIT", File.read(old_pid).to_i)
#     rescue Errno::ENOENT, Errno::ESRCH
#       puts "Send 'QUIT' signal to unicorn error!"
#     end
#   end
# end
#
# before_fork do |server, worker|
#   server.logger.info("worker=#{worker.nr} spawning in #{Dir.pwd}")
#
#   # graceful shutdown.
#   old_pid_file = project_home + '/tmp/pids/unicorn.pid.oldbin'
#   if File.exists?(old_pid_file) && server.pid != old_pid_file
#     begin
#       old_pid = File.read(old_pid_file).to_i
#       server.logger.info("sending QUIT to #{old_pid}")
#       # we're killing old unicorn master right there
#       Process.kill("QUIT", old_pid)
#     rescue Errno::ENOENT, Errno::ESRCH
#       # someone else did our job for us
#     end
#   end
# end
#
#
# after_fork do |server, worker|
#   defined?(ActiveRecord::Base) and
#       ActiveRecord::Base.establish_connection
# end
