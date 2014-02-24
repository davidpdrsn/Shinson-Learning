# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

ShinsonLearning::Application.load_tasks

namespace :heroku do
  desc "Deploy app to heroku"
  task :deploy do
    `git push herou master && heroku run rake db:migrate`
  end

  desc "Restart heroku app"
  task :restart do
    `heroku restart --app shinson-learning`
  end
end
