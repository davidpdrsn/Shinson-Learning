namespace :db do
  desc "add test data to database"
  task :add_test_data do
    include FactoryGirl::Syntax::Methods

    [User, Technique].map &:destroy_all

    create(:user, email: "david.pdrsn@gmail.com",
           password: "passwordlol",
           password_confirmation: "passwordlol")

    10.times do
      user = create(:user)
      puts "Made user: #{user.id}"
    end

    1_000.times do |n|
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
