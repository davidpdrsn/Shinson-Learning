# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  first_name             :string(255)
#  last_name              :string(255)
#

require 'spec_helper'

describe User do
  it { should have_many(:techniques).dependent(:destroy) }
  it { should have_many(:notes).dependent(:destroy) }
  it { should have_many(:studies).dependent(:destroy) }

  describe "#questions" do
    it "delegates to Note and includes techniques" do
      user = create :user
      question_list = double('question_list')
      question_list.stub(:includes).with(:technique)
      Note.stub(:questions).and_return(question_list)
      user.questions

      expect(Note).to have_received :questions
      expect(question_list).to have_received(:includes).with(:technique)
    end
  end

  describe "#sorted_techniques" do
    it "returns the techqniues for the user, sorted" do
      user = create :user
      technique = create :technique, user: user
      another_technique = create :technique, user: user

      expect(user.sorted_techniques).to eq [technique, another_technique]
    end
  end

  describe "#admin" do
    let(:user) { create :user }

    it "returns true if the user is an admin" do
      create :admin_user, email: user.email

      expect(user).to be_admin
    end

    it "return false if the user is not an admin" do
      expect(user).not_to be_admin
    end
  end

  describe "#neglected_studies" do
    it "delegates to Study" do
      user = create :user
      Study.stub(:neglected)
      user.neglected_studies

      expect(Study).to have_received :neglected
    end
  end

  describe "#techniques_grouped_by" do
    it "delegates to grouper" do
      user = create :user
      fake_grouper = double.as_null_object
      Grouper.stub(:new) { fake_grouper }
      user.techniques_grouped_by :one, :two

      expect(Grouper).to have_received(:new).with(user.techniques)
      expect(fake_grouper).to have_received(:group_by).with(:one, :two)
    end
  end

  describe "#techniques_as_hash" do
    it "returns the techniques as a hash" do
      user = create :user
      technique = create :technique, user: user
      create :note, technique: technique, user: user
      hash = user.techniques_as_hash

      expect(hash.length).to eq 1
      expect(hash.first["id"]).to eq technique.id
      expect(hash.first["notes"].length).to eq 1
    end
  end

  describe "#sorted_studies" do
    it "delegates to Study" do
      user = create :user
      Study.stub(:sorted_by_name)
      user.sorted_studies

      expect(Study).to have_received :sorted_by_name
    end
  end
end
