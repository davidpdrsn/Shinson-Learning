FactoryGirl.define do
  factory :admin_user do
    sequence :email do |n|
      "person#{n}@example.com"
    end
    password "passwordlol"
    password_confirmation "passwordlol"
  end
end
