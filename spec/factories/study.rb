FactoryGirl.define do
  factory :study do
    user
    sequence :name do |n|
      "study name #{n}"
    end

    ignore do
      techniques_count 1
    end

    before(:create) do |study, evaluator|
      techniques = create_list :technique, evaluator.techniques_count, user: study.user
      study.techniques = techniques
    end
  end
end
