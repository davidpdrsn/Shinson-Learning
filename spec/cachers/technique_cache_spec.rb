require 'spec_helper'

describe TechniqueCache do
  describe "#category_name" do
    it "returns the category name", caching: true do
      kicks = double name: "kicks"
      punches = double name: "punches"
      technique = build_stubbed :technique
      cache = TestCache.new
      technique_cache = TechniqueCache.new technique, cache

      test_cache_behavior(cache) { technique_cache.category_name }

      technique.stub category: kicks
      expect(technique_cache.category_name).to eq "kicks"

      technique.stub category: punches
      expect(technique_cache.category_name).to eq "punches"

    end
  end

  describe "#belt_pretty_print" do
    it "returns the pretty print for the belt", caching: true do
      white = double pretty_print: "white"
      yellow = double pretty_print: "yellow"
      technique = build_stubbed :technique
      cache = TestCache.new
      technique_cache = TechniqueCache.new technique, cache

      test_cache_behavior(cache) { technique_cache.category_name }

      technique.stub belt: white
      expect(technique_cache.belt_pretty_print).to eq "white"

      technique.stub belt: yellow
      expect(technique_cache.belt_pretty_print).to eq "yellow"
    end
  end
end
