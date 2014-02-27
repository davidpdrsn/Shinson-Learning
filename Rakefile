# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

ShinsonLearning::Application.load_tasks

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

namespace :db do
  desc "add test data to database"
  task :add_test_data do
    include FactoryGirl::Syntax::Methods

    Technique.destroy_all
    User.destroy_all

    create(:user, email: "david.pdrsn@gmail.com",
           password: "passwordlol",
           password_confirmation: "passwordlol")

    10.times do
      user = create(:user)
      puts "Made user: #{user.id}"
    end

    10_000.times do |n|
      user = User.all.sample
      technique = Technique.new(
        name: "technique ##{n}",
        description: "descript for technique ##{n}",
        belt: Belt.all.sample,
        category: Category.all.sample,
        user: user
      )
      if technique.save
        p "Created technique ##{n} for user ##{user.id}"
      end
    end
  end
end
