# config valid only for Capistrano 3.1
lock '3.2.1'

set :application, 'shinson_learning'
set :repo_url, 'git@github.com:davidpdrsn/Shinson-Learning.git'
set :deploy_to, "/home/deployer/apps/#{fetch :application}"
set :pty, true
set :linked_files, ["config/database.yml", "config/application.yml"]
set :linked_dirs, ["bin", "log", "tmp/pids", "tmp/cache",
                   "tmp/sockets", "vendor/bundle", "public/system"]
set :rbenv_type, :user
set :rbenv_ruby, "2.1.4"
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} " \
  "RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w(rake gem bundle ruby rails)
set :rbenv_roles, :all

namespace :deploy do
  desc "Restart application"
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute "sudo /etc/init.d/apache2 restart"
    end
  end

  after :publishing, :restart
end
