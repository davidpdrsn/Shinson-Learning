require 'spec_helper'

describe Study do
  it { should belong_to :user }
  it { should belong_to :belt }
  it { should belong_to :category }

  describe "#techniques" do
    it "returns the number of techniques for the study" do
      category = create :category
      belt = create :belt
      user = create :user
      4.times { create :technique, belt: belt, category: category, user: user }
      study = create :study, category: category, belt: belt, user: user

      expect(study.techniques).to have(4).techniques
    end
  end

  describe "#pretty_print" do
    it "pretty prints the study" do
      study = create :study

      expect(study.pretty_print).to eq "#{study.belt.pretty_print} #{study.category.name}"
    end
  end
end
