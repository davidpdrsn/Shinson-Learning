require 'spec_helper'

describe Score do
  it { should belong_to :study }
  it { should belong_to :user }

  describe "#to_percent" do
    it "delegates to CalculatesPercentages" do
      score = build :score
      allow(score).to receive(:correct_answers).and_return(1)
      allow(score).to receive(:study).and_return(double(techniques: double(count: 4)))

      allow(MathHelper).to receive(:percentage_difference).with(1, 4)

      score.to_percent

      expect(MathHelper).to have_received(:percentage_difference).with(1, 4)
    end
  end
end
