FactoryGirl.define do
  factory :technique do
    sequence :name do |n|
      "technique#{n}"
    end
    description "Something something darkside"
    category
    belt
    user
  end
end
