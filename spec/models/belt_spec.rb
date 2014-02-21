require 'spec_helper'

describe Belt do
  it { should have_many :techniques }

  it { should validate_presence_of :color }
  it { should validate_presence_of :degree }
  it { should validate_uniqueness_of :degree }

  describe "#pretty_print" do
    it "pretty prints the belt" do
      belt = build(:belt, color: "white", degree: "Mu kup")

      expect(belt.pretty_print).to eq "White (mu kup)"
    end
  end
end
