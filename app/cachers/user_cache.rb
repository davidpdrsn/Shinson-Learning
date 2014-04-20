class UserCache < Cacher
  def studies_count
    @cache.fetch [@user, :studies_count] do
      @user.studies.count
    end
  end

  def notes_count
    @cache.fetch [@user, :notes_count] do
      @user.notes.count
    end
  end

  def techniques_count
    @cache.fetch [@user, :techniques_count] do
      @user.techniques.count
    end
  end
end
