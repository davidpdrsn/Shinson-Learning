namespace :db do
  desc "add test data to database"
  task :add_test_data do
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

    study = me.studies.create! category: category, belt: belt

    100.times do |n|
      study.scores.create! correct_answers: (1..study.techniques.count).to_a.sample,
                           created_at: n.days.ago
    end
  end
end
