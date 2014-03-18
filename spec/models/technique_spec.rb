# == Schema Information
#
# Table name: techniques
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :text
#  belt_id     :integer
#  created_at  :datetime
#  updated_at  :datetime
#  category_id :integer
#  user_id     :integer
#  notes_count :integer          default(0), not null
#

require 'spec_helper'

describe Technique do
  it { should belong_to :belt }
  it { should belong_to :category }
  it { should belong_to :user }
  it { should have_many(:notes).dependent(:destroy) }
  it { should have_and_belong_to_many :studies }

  it { should validate_presence_of :name }
  it { should validate_presence_of :belt_id }
  it { should validate_presence_of :category_id }
  it { should validate_presence_of :user_id }
  it { should validate_presence_of :description }

  it { should delegate(:name).to(:category).with_prefix }
  it { should delegate(:pretty_print).to(:belt).with_prefix }

  it "compares the names and the numbers in the name" do
    a = build :technique, name: "Gibon sul 2"
    b = build :technique, name: "Gibon sul 10"
    c = build :technique, name: "Gibon sul"

    expect(a).to be < b
    expect(c).to be < a
  end

  describe "#to_param" do
    it "converts the name into a param for url" do
      technique = build_stubbed :technique, name: "gibon sul 1"

      expect(technique.to_param).to eq "#{technique.id}-gibon-sul-1"
    end
  end

  describe "#for_user_grouped_by" do
    it "delegates to grouper" do
      techniques = [build(:technique), build(:technique)]
      user = double sorted_techniques: techniques
      fake_grouper = double.as_null_object
      Grouper.stub(:new) { fake_grouper }
      Technique.for_user_grouped_by(user, :one, :two)

      expect(Grouper).to have_received(:new).with(techniques)
      expect(fake_grouper).to have_received(:group_by).with(:one, :two)
    end
  end

  describe ".as_hash_for_user" do
    it "returns the techniques as a hash" do
      user = create :user
      technique = create :technique, user: user
      create :note, technique: technique, user: user
      hash = Technique.as_hash_for_user user

      expect(hash.length).to eq 1
      expect(hash.first["id"]).to eq technique.id
      expect(hash.first["notes"].length).to eq 1
    end
  end

  describe ".unstudied_for_user" do
    it "returns techniques that have not been studied" do
      user = create :user
      technique = create :technique, user: user
      study = create :study, user: user
      other_techniques = study.techniques

      expect(Technique.unstudied_for_user(user)).to eq [technique]
      expect(Technique.unstudied_for_user(user)).not_to include other_techniques
    end
  end
end
