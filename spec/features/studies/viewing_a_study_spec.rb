require 'spec_helper'

feature 'viewing a study' do
  scenario "user views a study" do
    study = create :study

    sign_in study.user
    click_link "Studies"
    click_link study.name

    expect(page).to have_content study.name
    expect(page).to have_content "#{study.techniques.count}"
  end
end
