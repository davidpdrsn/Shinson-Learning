require "spec_helper"

describe StudyCache do
  describe "#average_score" do
    it "caches average score", caching: true do
      study = create :study, techniques_count: 10
      cache = TestCache.new
      study_cache = StudyCache.new(study, cache)
      create :score, study: study, correct_answers: 9, user: study.user

      test_cache_behavior(cache) { study_cache.average_score }

      expect do
        create :score, study: study, correct_answers: 5, user: study.user
      end.to change { study_cache.average_score }
    end
  end

  describe "#scores_count" do
    it "caches the number of scores" do
      study = create :study, techniques_count: 10
      cache = TestCache.new
      study_cache = StudyCache.new(study, cache)
      create :score, study: study, correct_answers: 9, user: study.user

      test_cache_behavior(cache) { study_cache.scores_count }

      expect do
        create :score, study: study, correct_answers: 5, user: study.user
      end.to change { study_cache.scores_count }
    end
  end
end
