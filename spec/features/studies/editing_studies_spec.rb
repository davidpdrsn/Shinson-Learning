require 'spec_helper'

feature 'editing studies' do
  let(:study) { create :study, name: "name of study" }
  before do
    sign_in study.user
    visit study_path(study)
    click_link "Edit"
  end

  scenario 'user sees the updated study' do
    fill_in "Name", with: "New name of study"
    click_button "Update Study"

    expect(page).to have_content "New name of study"
  end

  scenario 'user tries to update the study with invalid information' do
    fill_in "Name", with: ""
    click_button "Update Study"

    expect(page).to have_content "can't be blank"
  end
end
