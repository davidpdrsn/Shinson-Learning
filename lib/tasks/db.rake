namespace :db do
  desc "add test data to database"
  task :add_test_data do
    system 'bin/rake db:seed'

    include FactoryGirl::Syntax::Methods

    [User, Technique, Study, Note, Score].map &:destroy_all

    me = create(:user, email: "david.pdrsn@gmail.com",
               password: "passwordlol",
               password_confirmation: "passwordlol")

    100.times do |n|
      technique = Technique.new(
        name: "technique ##{n}",
        description: "descript for technique ##{n}",
        belt: Belt.all.sample,
        category: Category.all.sample,
        user: me
      )
      if technique.save
        p "Created technique ##{n} for user ##{me.id}"
      end
    end

    technique = me.techniques.first
    category = technique.category
    belt = technique.belt
  end
end
