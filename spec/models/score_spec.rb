require 'spec_helper'

describe Score do
  it { should belong_to :study }
  it { should belong_to :user }

  describe "#to_percent" do
    context "when there are no correct answers" do
      it "returns 0%" do
        score = create :score, correct_answers: 0

        expect(score.to_percent).to eq 0
      end
    end

    context "with an intermediate score" do
      it "returns 75%" do
        score = create :score, correct_answers: 3
        score.stub(:study) { double techniques: (1..4).to_a }

        expect(score.to_percent).to eq 75
      end
    end

    context "with all answers correct" do
      it "returns 100%" do
        score = create :score, correct_answers: 10
        score.stub(:study) { double techniques: (1..10).to_a }

        expect(score.to_percent).to eq 100
      end
    end
  end
end
