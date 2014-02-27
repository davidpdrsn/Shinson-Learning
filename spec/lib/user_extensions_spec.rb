require_relative '../../lib/user_extensions'

class DummyUser
  include UserExtensions
  include UserExtensions::Queries
end

class AddsS; end

describe UserExtensions do
  let(:user) { DummyUser.new }

  describe "#s" do
    it "delegates to AddsS" do
      screen_name = "David"
      AddsS.stub(:on)

      user.stub(:screen_name) { screen_name }
      user.s

      expect(AddsS).to have_received(:on).with(screen_name)
    end
  end

  describe "#screen_name" do
    before do
      [:email, :first_name, :last_name].each do |m|
        user.stub m
      end
    end

    it "returns email when provided with only email" do
      expect(user.screen_name).to eq user.email
    end

    it "returns the first name when provided with first name" do
      user.stub(:first_name) { "bob" }
      expect(user.screen_name).to eq "Bob"
    end

    it "returns the last name when provided with last name" do
      user.stub(:last_name) { "johnson" }
      expect(user.screen_name).to eq "Johnson"
    end

    it "returns the full when provided with first and last name" do
      user.stub(:last_name) { "johnson" }
      user.stub(:first_name) { "bob" }
      expect(user.screen_name).to eq "Bob Johnson"
    end
  end
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
