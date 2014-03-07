require 'spec_helper'

describe TechniquePresenter do
  describe "#category_name" do
    it "returns the category name", caching: true do
      kicks = double name: "kicks"
      punches = double name: "punches"
      technique = double
      technique_presenter = TechniquePresenter.new technique, view

      technique.stub category: kicks
      expect(technique_presenter.category_name).to eq "kicks"

      technique.stub category: punches
      expect(technique_presenter.category_name).to eq "punches"
    end
  end

  describe "#belt_pretty_print" do
    it "returns the pretty print for the belt", caching: true do
      white = double pretty_print: "white"
      yellow = double pretty_print: "yellow"
      technique = double
      technique_presenter = TechniquePresenter.new technique, view

      technique.stub belt: white
      expect(technique_presenter.belt_pretty_print).to eq "white"

      technique.stub belt: yellow
      expect(technique_presenter.belt_pretty_print).to eq "yellow"
    end
  end
end
