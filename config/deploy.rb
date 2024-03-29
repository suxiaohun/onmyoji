# config valid for current version and patch releases of Capistrano
lock "~> 3.11.0"

set :rvm_map_bins, %w{gem rake ruby rails bundle}
ask :deploy_option, 'simple'
set :application, "onmyoji"
set :ruby_version, "2.6.3"
set :repo_url, "git@github.com:suxiaohun/onmyoji.git"

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, "/home/crystal/onmyoji"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
append :linked_files, "config/database.yml", "config/master.key"

# Default value for linked_dirs is []
append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system", 'app/assets/videos'

# tmp/pids/unicorn.pid
set :unicorn_pid, -> { File.join(current_path, "tmp", "pids", "unicorn.pid") }
set :unicorn_config_path, -> { File.join(current_path, "config", "unicorn.rb") }


namespace :xiaosu do
  desc 'link books directory'
  task :link_books do
    on roles(:all) do
      within release_path do
        puts_front "start link books..."
        execute :ln, '-s', "/home/crystal/books public/"
        puts_end
      end
    end
  end

  desc 'init books'
  task :init_books do
    on roles(:all) do
      within release_path do
        puts_front "start init books..."
        execute :rake, 'book:init', "RAILS_ENV=production"
        puts_end
      end
    end
  end

  desc 'init data'
  task :init_yys do
    on roles(:all) do
      within release_path do
        puts_front "init yys data..."
        execute :rake, 'yys:init', 'RAILS_ENV=production'
        puts_end
      end
    end
  end

  desc 'check unicorn restart correct'
  task :check_unicorn_restart_correct do
    on roles(:all) do
      within release_path do
        puts_front "init db books..."
        execute :rake, 'db:seed', 'RAILS_ENV=production'
        puts_end
      end
    end
  end


  task :restart do
    invoke 'unicorn:legacy_restart'
  end

  desc 'notice_refresh'
  task :notice_refresh do
    on roles(:all) do
      within release_path do
        sleep 10
        puts_front "发版通知..."
        execute :rake, 'app_version:update', 'RAILS_ENV=production'
        puts_end
      end
    end
  end


  # task :restart do
  #   on roles(:all) do
  #     puts "-------------||-----------------"
  #     within release_path do
  #       puts_front "restart_unicorn..."
  #       print 'old unicorn pid:  '
  #       execute :cat, 'tmp/pids/unicorn.pid'
  #       puts_end
  #     end
  #
  #     invoke 'unicorn:legacy_restart'
  #
  #     within release_path do
  #       puts_front "restart_unicorn..."
  #       print 'new unicorn pid:  '
  #       execute :cat, 'tmp/pids/unicorn.pid'
  #       puts_end
  #     end
  #   end
  # end


  def puts_front(str)
    puts
    puts '+----------------------------------------------------------------------------------------+'
    puts '|                                                                                        |'
    puts '|                                                                                        |'
    puts "\e[48;5;34m\033[5m #{str} \e[0m"

  end

  def puts_end
    puts '|                                                                                        |'
    puts '|                                                                                        |'
    puts '+----------------------------------------------------------------------------------------+'

    puts
  end


  #
  # task :hello do
  #   on roles(:all) do |host|
  #     execute :sudo, :cp, '~/something', '/something'
  #   end
  # end


  after 'deploy:publishing', 'xiaosu:link_books'
  after 'deploy:publishing', 'xiaosu:restart'

  deploy_option = fetch(:deploy_option)
  unless deploy_option == 'simple'
    #after 'deploy:publishing', 'xiaosu:init_books'
    after 'deploy:publishing', 'xiaosu:init_yys'
    after 'xiaosu:restart', 'xiaosu:notice_refresh'
  end

end


# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
# set :keep_releases, 5

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure
