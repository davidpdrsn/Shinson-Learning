FactoryGirl.define do
  factory :note do
    text "note text is here"
    question false
    technique
    user

    factory :question do
      question true
    end
  end
end
