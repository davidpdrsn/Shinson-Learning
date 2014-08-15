class StudyCache < Cacher
  def average_score
    @cache.fetch([@study, :average_score]) do
      @study.average_score
    end
  end

  def scores_count
    @cache.fetch([@study, :scores_count]) do
      @study.scores.count
    end
  end
end
