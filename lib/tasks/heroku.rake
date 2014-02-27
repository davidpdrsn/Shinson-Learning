namespace :heroku do
  desc "Deploy app to heroku"
  task :deploy do
    `git push heroku master && heroku run rake db:migrate`
  end

  desc "Restart heroku app"
  task :restart do
    `heroku restart --app shinson-learning`
  end
end
