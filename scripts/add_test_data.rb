include FactoryGirl::Syntax::Methods

Technique.destroy_all
User.destroy_all

create(:user, email: "david.pdrsn@gmail.com",
       password: "passwordlol",
       password_confirmation: "passwordlol")

100.times do
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
