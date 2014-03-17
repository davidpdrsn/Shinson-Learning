require 'spec_helper'

describe "home/signed_in" do
  let(:user) { create :user }
  let(:study) { create :study, user: user }

  before do
    controller.stub(:current_user).and_return(user)
  end

  context "when the user has no neglected studies" do
    it "shows that the user is doing a good job" do
      assign(:neglected_studies, [])

      with_rendered_page do |page|
        expect(page).to have_content "You're doing good on your studies!"
        expect(page).not_to have_content "You should consider studying"
      end
    end
  end

  context "when the user has neglected studies" do
    it "shows a list of them" do
      assign(:neglected_studies, [study])

      with_rendered_page do |page|
        expect(page).not_to have_content "You're doing good on your studies!"
        expect(page).to have_content "You should consider studying"
        expect(page).to have_link study.name
      end
    end
  end
end
