lock '3.2.1'

set :application, 'shinson_learning'
set :repo_url, 'https://github.com/davidpdrsn/Shinson-Learning.git'
set :user, "deployer"

set :deploy_to, "/home/#{fetch :user}/apps/#{fetch :application}"

set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}
set :linked_files, %w{config/database.yml config/application.yml}

set :rbenv_type, :system
set :rbenv_ruby, '2.1.1'
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w{rake gem bundle ruby rails}
set :rbenv_roles, :all # default value

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
after :deploy, 'deploy:tag_ref'
after 'deploy:publishing', 'deploy:restart'
