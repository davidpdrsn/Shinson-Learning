FactoryGirl.define do
  factory :belt do
    color "white"
    sequence :degree do |n|
      "#{n}. kup"
    end
  end
end
