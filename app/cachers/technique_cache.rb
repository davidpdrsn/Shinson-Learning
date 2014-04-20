class TechniqueCache < Cacher
  def category_name
    @cache.fetch([@technique, @technique.category]) do
      @technique.category.name
    end
  end

  def belt_pretty_print
    @cache.fetch([@technique, @technique.belt]) do
      @technique.belt.pretty_print
    end
  end
end
