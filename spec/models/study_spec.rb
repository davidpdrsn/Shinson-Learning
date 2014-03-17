require 'spec_helper'

describe Study do
  it { should belong_to :user }
  it { should have_and_belong_to_many :techniques }
  it { should have_many(:scores).dependent(:destroy) }

  it { should validate_presence_of :name }

  it "is invalild without techniques" do
    study = build :study

    expect(study).not_to be_valid
  end

  it "is invalid unless all techniques are from the same user" do
    study = build :study
    study.techniques << create(:technique)

    expect(study).not_to be_valid
  end

  it "isn't valid if the user already has a study with the same name" do
    study = create :study
    another_study = build :study, user: study.user, name: study.name

    expect(another_study).not_to be_valid
  end

  describe "#to_json" do
    it "converts the study to json" do
      study = build :study

      json = JSON.parse study.to_json
      expect(json["study"]["id"]).to eq study.id
      expect(json["techniques"].length).to eq study.techniques.length
    end
  end

  describe "#average_score" do
    it "delegates to MathHelper" do
      study = build :study
      MathHelper.should_receive(:average).and_return(10)
      study.average_score
    end
  end

  describe "#newest_score" do
    it "finds the newest score" do
      study = build :study
      study.techniques << create(:technique, user: study.user)
      new_score = create :score, study: study, created_at: 1.day.ago
      old_score = create :score, study: study, created_at: 2.weeks.ago

      expect(study.newest_score).to eq new_score
    end

    it "returns nil when there it has no scores" do
      study = build :study

      expect(study.newest_score).to be_nil
    end
  end

  describe ".neglected_for_user" do
    let(:user) { create :user }

    it "returns studies that have never been studied" do
      never_studied = create :study, user: user

      expect(Study.neglected_for_user user).to include never_studied
    end

    it "returns studies that haven't been studied for a while" do
      not_studied_for_a_while = create :study, user: user
      create :score, study: not_studied_for_a_while, user: user, created_at: 2.weeks.ago

      expect(Study.neglected_for_user user).to include not_studied_for_a_while
    end

    it "doesn't return studies that have been studied recently" do
      studied = create :study, user: user
      create :score, study: studied, user: user

      expect(Study.neglected_for_user user).not_to include studied
    end
  end
end
