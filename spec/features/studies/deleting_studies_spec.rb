require 'spec_helper'

feature "deleting studies" do
  scenario 'user sees that the study has been deleted' do
    study = create :study

    sign_in study.user
    click_link "Studies"
    click_link study.name
    click_link "Delete"

    expect(page).to have_content "Study deleted"
    expect(page).not_to have_content study.name
  end
end
