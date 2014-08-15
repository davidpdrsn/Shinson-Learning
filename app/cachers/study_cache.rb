class StudyCache < Cacher
  def average_score
    @cache.fetch([@study, :average_score]) do
      @study.average_score
    end
  end
end
