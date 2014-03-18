# == Schema Information
#
# Table name: scores
#
#  id              :integer          not null, primary key
#  user_id         :integer
#  study_id        :integer
#  correct_answers :integer
#  created_at      :datetime
#  updated_at      :datetime
#

require 'spec_helper'

describe Score do
  it { should belong_to :study }
  it { should belong_to :user }

  describe "#to_percent" do
    it "delegates to CalculatesPercentages" do
      score = build :score
      score.stub(:correct_answers) { 1 }
      score.stub(:study) { double(techniques: double(count: 4)) }

      MathHelper.should_receive(:percentage_difference).with(1, 4)

      score.to_percent
    end
  end
end
