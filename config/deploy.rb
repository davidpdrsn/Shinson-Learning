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

namespace :deploy do
  desc "tag current revision as production"
  task :tag_ref do
    tag_name = "production"
    system "git tag -d #{tag_name}"
    system "git tag #{tag_name}"
  end

  desc "Clear cache"
  task :clear_cache do
    on roles(:all) do
      execute "cd /home/deployer/apps/shinson_learning/current; bin/rake cache:clear RAILS_ENV=production"
    end
  end
end

namespace :deploy do
  task :restart do
    invoke 'unicorn:restart'
  end
end

after :deploy, 'deploy:tag_ref'
after 'deploy:publishing', 'deploy:restart'
