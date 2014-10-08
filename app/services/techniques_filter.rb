class TechniquesFilter
  def initialize(techniques_to_filter, categories, belts)
    @techniques_to_filter = techniques_to_filter
    @categories = categories
    @belts = belts
  end

  def techniques
    grouped_techniques_for_export
  end

  private

  attr_reader :techniques_to_filter, :categories, :belts

  def grouped_techniques_for_export
    Grouper.new(sorted_chosen_techniques).group_by(:belt_pretty_print, :category_name)
  end

  def sorted_chosen_techniques
    techniques_to_filter.select do |technique|
      technique_should_be_exported(technique)
    end
  end

  def technique_should_be_exported(technique)
    categories.include?(technique.category_id.to_s) &&
      belts.include?(technique.belt_id.to_s)
  end
end
