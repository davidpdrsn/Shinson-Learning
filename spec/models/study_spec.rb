require 'spec_helper'

describe Study do
  it { should belong_to :user }
  it { should belong_to :belt }
  it { should belong_to :category }
  it { should have_many(:scores).dependent(:destroy) }

  describe "#techniques" do
    it "returns the number of techniques for the study" do
      category = create :category
      belt = create :belt
      user = create :user
      4.times { create :technique, belt: belt, category: category, user: user }
      study = create :study, category: category, belt: belt, user: user

      expect(study.techniques).to have(4).techniques
    end
  end

  describe "#pretty_print" do
    it "pretty prints the study" do
      study = create :study

      expect(study.pretty_print).to eq "#{study.belt.pretty_print} #{study.category.name}"
    end
  end

  describe "#to_json" do
    it "converts the study to json" do
      study = create :study

      json = JSON.parse study.to_json
      expect(json["study"]["id"]).to eq study.id
      expect(json["techniques"].length).to eq study.techniques.length
    end
  end

  describe "#average_score" do
    it "returns the average score for the study" do
      study = create :study
      4.times { create :technique, belt: study.belt, category: study.category, user: study.user }
      create :score, study: study, user: study.user, correct_answers: 0
      create :score, study: study, user: study.user, correct_answers: 4

      expect(study.average_score).to eq 50
    end

    it "returns 0 when there are no scores" do
      study = create :study
      4.times { create :technique, belt: study.belt, category: study.category, user: study.user }

      expect(study.average_score).to eq 0
    end
  end

  describe "#newest_score" do
    it "finds the newest score" do
      study = build :study
      new_score = create :score, study: study, created_at: 1.day.ago
      old_score = create :score, study: study, created_at: 2.weeks.ago

      expect(study.newest_score).to eq new_score
    end

    it "returns nil when there it has no scores" do
      study = build :study

      expect(study.newest_score).to be_nil
    end
  end
end
