require_relative '../../lib/math_helper'

describe MathHelper do
  describe "#percentage_difference" do
    it "calculates percentages" do
      MathHelper.percentage_difference(1, 4).should eq 25
      MathHelper.percentage_difference(0, 4).should eq 0
      MathHelper.percentage_difference(5, 10).should eq 50
      MathHelper.percentage_difference(5, 0).should eq 0
    end
  end

  describe "#average" do
    it "calculates the average of a list of values" do
      MathHelper.average([1,2,3,4,5]).should eq 3.0
      MathHelper.average([]).should eq 0.0
    end
  end
end
