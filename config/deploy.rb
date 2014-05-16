# config valid only for Capistrano 3.1
lock '3.2.1'

set :application, 'shinson_learning'
set :repo_url, 'https://github.com/davidpdrsn/Shinson-Learning.git'
set :user, "deployer"

# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }.call

# Default deploy_to directory is /var/www/my_app
set :deploy_to, "/home/#{fetch :user}/apps/#{fetch :application}"

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# set :linked_files, %w{config/database.yml}

# Default value for linked_dirs is []
set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}
set :linked_files, %w{config/database.yml config/application.yml}

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

# after 'deploy', 'deploy:clear_cache'
# after 'deploy', 'deploy:tag_ref'

namespace :deploy do
  # desc "tag current revision as production"
  # task :tag_ref do
  #   tag_name = "production"
  #   system "git tag -d #{tag_name}"
  #   system "git tag #{tag_name}"
  # end

  # desc "clear cache"
  # task :clear_cache do
  #   execute "cd #{current_path}; bundle exec rake tmp:clear RAILS_ENV=#{rails_env}"
  # end

  %w[start stop restart].each do |command|
    desc "#{command} unicorn server"
    task command do
      on roles(:all) do |host|
        execute "/etc/init.d/unicorn_#{fetch :application} #{command}"
      end
    end
  end

  after :publishing, :restart

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

end
