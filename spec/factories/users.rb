FactoryGirl.define do
  factory :user do
    sequence :email do |n|
      "person#{n}@example.com"
    end
    first_name "bob"
    last_name "johnson"
    password "passwordlol"
    password_confirmation "passwordlol"
  end
end
