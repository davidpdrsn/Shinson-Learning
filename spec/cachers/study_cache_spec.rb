require "spec_helper"

describe StudyCache do
  it "caches average score", caching: true do
    study = create :study, techniques_count: 10
    study_cache = StudyCache.new(study)
    a = create :score, study: study, correct_answers: 9, user: study.user

    p study.average_score

    b = create :score, study: study, correct_answers: 5, user: study.user

    p study.average_score
    p study.scores
  end
end
