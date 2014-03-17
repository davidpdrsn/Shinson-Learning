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
    it "returns the notes that are also questions for the user" do
      user = create :user
      question = create :question, user: user

      expect(user.questions).to eq [question]
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
end
