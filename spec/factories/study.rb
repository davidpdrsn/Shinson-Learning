FactoryGirl.define do
  factory :study do
    category
    belt
    user

    ignore do
      techniques_count 1
    end

    before(:create) do |study, evaluator|
      unless study.techniques.present?
        create_list :technique,
                    evaluator.techniques_count,
                    user: study.user,
                    category: study.category,
                    belt: study.belt
      end
    end
  end
end
