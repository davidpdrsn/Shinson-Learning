require 'spec_helper'

feature "study" do
  scenario "user creates a new study", focus: true, js: true do
    bob = create :user
    kicks = create :category
    su = create :category
    white = create :belt

    create :technique, user: bob, belt: white, category: kicks, name: "ap chagi"
    create :technique, user: bob, belt: white, category: kicks, name: "dollyo chagi"
    create :technique, user: bob, belt: white, category: su, name: "gibon sul 1"

    sign_in bob

    click_link "Studies"
    click_link "+"
    fill_in "Name of study", with: "Misc study"
    fill_in "Search query", with: "chagi"
    click_link "ap chagi"
    click_link "dollyo chagi"
    fill_in "Search query", with: "sul"
    click_link "gibon sul 1"
    click_button "Create Study"

    expect(page).to have_content "Misc study"
    expect(page).to have_content "3 techniques"
  end

  scenario "user views a study" do
    study = create :study

    sign_in study.user
    click_link "Studies"
    click_link study.name

    expect(page).to have_content study.name
    expect(page).to have_content "#{study.techniques.count} technique"
  end

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
