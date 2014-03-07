class TechniquePresenter < Presenter
  presents :technique
  delegate :name, to: :technique
  delegate :user, to: :technique
  delegate :description, to: :technique

  def category_name
    Rails.cache.fetch([technique, technique.category]) { technique.category.name }
  end

  def belt_pretty_print
    Rails.cache.fetch([technique, technique.belt]) { technique.belt.pretty_print }
  end

  # TODO: test this
  def link
    h.link_to name, technique, class: "technique__link"
  end

  # TODO: test this
  def human_note_count
    h.content_tag :span, "(#{note_count})", class: "note-count"
  end

  private

  def note_count
    h.pluralize technique.notes_count, "note"
  end
end
