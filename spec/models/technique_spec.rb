require 'spec_helper'

describe Technique do
  it { should belong_to :belt }
  it { should belong_to :category }
  it { should belong_to :user }

  it { should validate_presence_of :name }
  it { should validate_uniqueness_of :name }
  it { should validate_presence_of :belt_id }
  it { should validate_presence_of :category_id }
  it { should validate_presence_of :user_id }
  it { should validate_presence_of :description }

  describe "#category_html_class" do
    it "delegates to category" do
      technique = create(:technique)
      technique.category.stub(:html_class)

      technique.category_html_class

      expect(technique.category).to have_received :html_class
    end
  end

  describe "#belt_pretty_print" do
    it "delegates to belt" do
      technique = create(:technique)
      technique.belt.stub(:pretty_print)

      technique.belt_pretty_print

      expect(technique.belt).to have_received :pretty_print
    end
  end
end
