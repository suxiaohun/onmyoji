# config valid for current version and patch releases of Capistrano
lock "~> 3.11.0"

set :application, "onmyoji"
set :repo_url, "https://github.com/suxiaohun/onmyoji.git"

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
append :linked_files, "config/database.yml","config/master.key"

# Default value for linked_dirs is []
append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"

set :unicorn_pid, -> { File.join(current_path,"tmp", "pids", "unicorn.pid") }
set :unicorn_config_path, -> { File.join(current_path, "config", "unicorn.rb") }

after 'deploy:publishing', 'deploy:restart'
namespace :deploy do
  task :restart do
    invoke 'unicorn:legacy_restart'
  end
end



namespace :udesk do
  desc 'link books'
  task :setup_property_file do
    on roles(:all) do
      within release_path do
        puts "============aaaa=============="
        execute :ln, '-s', "/home/crystal/books public/"
      end
    end
  end

   desc 'init data'
  task :init_data do
    on roles(:all) do
      within release_path do
        puts "============bbbbb=============="
        execute 'rake db:seed'
      end
    end
  end





  #
  # task :hello do
  #   on roles(:all) do |host|
  #     execute :sudo, :cp, '~/something', '/something'
  #   end
  # end


  after 'deploy:updating',   'udesk:setup_property_file'
  after 'deploy:updating',   'udesk:init_data'

end




# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
# set :keep_releases, 5

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure
