require 'spec_helper'

describe User do
  it { should have_many :techniques }
  it { should have_many :notes }

  describe "#questions" do
    it "find the users questions" do
      user = create(:user)
      another_user = create(:user)
      note = create(:note, user: user)
      question = create(:question, user: user)
      another_question = create(:question, user: another_user)

      expect(user.questions).to eq [question]
    end
  end
end
