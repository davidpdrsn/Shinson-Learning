module TechniqueExtensions
  module Delegators
    def category_name
      category.name
    end

    def belt_pretty_print
      belt.pretty_print
    end
  end

  module Comparisons
    include Comparable

    def <=>(another)
      name_to_a(self) <=> name_to_a(another)
    end

    private

    def name_to_a(technique)
      match = technique.name.match(/(?<string>.*?)(?<digit>\d+)$/)

      if match
        [match[:string], match[:digit].to_i]
      else
        [technique.name]
      end
    end
  end
end
