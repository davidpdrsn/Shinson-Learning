require "spec_helper"

describe StudyCache do
  describe "#average_score" do
    it "caches average score", caching: true do
      study = create :study, techniques_count: 10
      study_cache = StudyCache.new(study)
      create :score, study: study, correct_answers: 9, user: study.user

      expect do
        create :score, study: study, correct_answers: 5, user: study.user
      end.to change { study_cache.average_score }
    end
  end
end
