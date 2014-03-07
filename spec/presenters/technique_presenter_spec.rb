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
end
