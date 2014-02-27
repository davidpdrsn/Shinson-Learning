require 'spec_helper'

describe User do
  it { should have_many(:techniques).dependent(:destroy) }
  it { should have_many(:notes).dependent(:destroy) }

  describe "#questions" do
    it "find the users questions" do
      user = create :user
      another_user = create :user
      note = create :note, user: user
      question = create :question, user: user
      another_question = create :question, user: another_user

      expect(user.questions).to eq [question]
    end
  end

  describe "#screen_name" do
    it "returns email when provided with only email" do
      user = build(:user, first_name: nil, last_name: nil)
      expect(user.screen_name).to eq user.email
    end

    it "returns the first name when provided with first name" do
      user = build(:user, first_name: "bob", last_name: nil)
      expect(user.screen_name).to eq "Bob"
    end

    it "returns the last name when provided with last name" do
      user = build(:user, first_name: nil, last_name: "johnson")
      expect(user.screen_name).to eq "Johnson"
    end

    it "returns the full when provided with first and last name" do
      user = build(:user, first_name: "bob", last_name: "johnson")
      expect(user.screen_name).to eq "Bob Johnson"
    end
  end

  describe "#s" do
    it "adds 's to the users screen name" do
      user = build :user, first_name: "Bob", last_name: "Johnson"

      expect(user.s).to eq "Bob Johnson's"
    end

    it "adds ' when the users name ends in s" do
      user = build :user, first_name: "Bob", last_name: "Johnsons"

      expect(user.s).to eq "Bob Johnsons'"
    end
  end
end
