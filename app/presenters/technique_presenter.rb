class TechniquePresenter < Presenter
  presents :technique

  def category_name
    Rails.cache.fetch([technique, technique.category]) { technique.category.name }
  end
end
