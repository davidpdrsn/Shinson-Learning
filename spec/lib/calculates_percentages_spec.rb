require_relative '../../lib/calculates_percentages'

describe CalculatesPercentages do
  it "calculates percentages" do
    CalculatesPercentages.of(1, 4).should eq 25
    CalculatesPercentages.of(0, 4).should eq 0
    CalculatesPercentages.of(5, 10).should eq 50
    CalculatesPercentages.of(5, 0).should eq 0
  end
end
