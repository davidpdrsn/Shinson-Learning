class TechniquePresenter < Presenter
  presents :technique

  def category_name
    Rails.cache.fetch([technique, technique.category]) { technique.category.name }
  end

  def belt_pretty_print
    Rails.cache.fetch([technique, technique.belt]) { technique.belt.pretty_print }
  end
end
