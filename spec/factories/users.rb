FactoryGirl.define do
  factory :user do
    sequence :email do |n|
      "person#{n}@example.com"
    end
    password "passwordlol"
    password_confirmation "passwordlol"
  end
end
