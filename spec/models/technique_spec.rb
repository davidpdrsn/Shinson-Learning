require 'spec_helper'

describe Technique do
  it { should belong_to :belt }
  it { should belong_to :category }
  it { should belong_to :user }
  it { should have_many :notes }

  it { should validate_presence_of :name }
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

  describe "#category_name" do
    it "delegates to category" do
      technique = create(:technique)
      technique.category.stub(:name)

      technique.category_name

      expect(technique.category).to have_received :name
    end
  end

  describe "#for_user_grouped_by" do
    it "finds the techniques for the user and groups them" do
      techniques = [build_stubbed(:technique), build_stubbed(:technique)]
      techniques.stub(:includes).and_return(techniques)
      user = build_stubbed(:user)
      user.stub(:techniques).and_return(techniques)
      fake_grouper = double(:grouper)
      Grouper.stub(:new).and_return(fake_grouper)
      fake_grouper.stub(:group_by)

      Technique.for_user_grouped_by(user, :category_name)

      expect(Grouper).to have_received(:new).with(techniques)
      expect(fake_grouper).to have_received(:group_by).with(:category_name)
    end
  end

  it "can be sorted" do
    a = create(:technique, name: "gibon sul 1")
    c = create(:technique, name: "gibon sul 10")
    b = create(:technique, name: "gibon sul 2")

    expect([c,b,a].sort).to eq [a,b,c]
  end
end
