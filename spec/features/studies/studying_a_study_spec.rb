require 'spec_helper'

feature 'studying studies' do
  scenario "user studies a study", js: true do
    study = create :study, techniques_count: 4

    sign_in study.user
    click_link "Studies"
    click_link study.name
    click_link "Study this"
    2.times do
      click_button "Flip"
      click_button "Guessed correctly"
    end
    2.times do
      click_button "Flip"
      click_button "Didn't guess correctly"
    end

    expect(page).to have_content "50.0%"
  end
end
