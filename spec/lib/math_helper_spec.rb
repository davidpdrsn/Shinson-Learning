require_relative '../../lib/math_helper'

describe MathHelper do
  describe "#percentage_difference" do
    it "calculates percentages" do
      expect(MathHelper.percentage_difference(1, 4)).to eq 25
      expect(MathHelper.percentage_difference(0, 4)).to eq 0
      expect(MathHelper.percentage_difference(5, 10)).to eq 50
      expect(MathHelper.percentage_difference(5, 0)).to eq 0
    end
  end

  describe "#average" do
    it "calculates the average of a list of values" do
      expect(MathHelper.average([1,2,3,4,5])).to eq 3.0
      expect(MathHelper.average([])).to eq 0.0
    end
  end
end
