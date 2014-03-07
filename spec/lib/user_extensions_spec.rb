require_relative '../../lib/user_extensions'

class DummyUser
  include UserExtensions
  include UserExtensions::Queries
end

describe UserExtensions::Queries do
  let(:user) { DummyUser.new }
  let(:fake_relation) { double.as_null_object }
  before { fake_relation.stub(:where).with(question: true) { fake_relation } }

  describe "#questions" do
    it "returns the questions for the user" do
      user.stub(:notes) { fake_relation }
      user.questions

      expect(fake_relation).to have_received(:includes).with(:technique)
    end
  end

  describe "#sorted_techniques" do
    it "returns the sorted techniques for the user" do
      user.stub(:techniques) { fake_relation }
      user.sorted_techniques

      expect(fake_relation).to have_received(:includes).with(:category, :belt)
      expect(fake_relation).to have_received :sort
    end
  end
end
