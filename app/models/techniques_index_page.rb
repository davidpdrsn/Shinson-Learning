class TechniquesIndexPage
  attr_reader :techniques, :default_grouping

  def initialize(techniques:, default_grouping:)
    @techniques = techniques
    @default_grouping = default_grouping
  end

  def has_techniques?
    @techniques.present?
  end
end
