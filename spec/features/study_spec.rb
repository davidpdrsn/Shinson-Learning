require 'spec_helper'

feature "study" do
  let(:bob) { create :user }
  let(:kicks) { create :category }
  let(:su) { create :category }
  let(:white) { create :belt }

  scenario "user creates a new study", js: true do
    10.times do |n|
      create :technique, user: bob, belt: white, category: kicks, name: "technique ##{n}"
    end

    sign_in bob

    click_link "Studies"
    click_link "+"
    fill_in "Name of study", with: "Misc study"
    fill_in "new-study__query", with: "tec"
    click_link "technique #1"
    click_link "technique #3"
    click_link "technique #2"
    click_link "technique #9"
    click_button "Create Study"

    expect(page).to have_content "Misc study"
    expect(page).to have_content "4 techniques"
  end

  scenario "user searches for a technique but doesn't find any matches", js: true do
    sign_in bob

    click_link "Studies"
    click_link "+"
    fill_in "Name of study", with: "Misc study"
    fill_in "new-study__query", with: "tec"

    expect(page).to have_content "No matches were found"
  end

  scenario "user searcher for techniques and adds all the matches", js: true do
    10.times do |n|
      create :technique, user: bob, belt: white, category: kicks, name: "technique ##{n}"
    end

    sign_in bob

    click_link "Studies"
    click_link "+"
    fill_in "Name of study", with: "Misc study"
    fill_in "new-study__query", with: "tec"
    click_button "Add all"
    click_button "Create Study"

    expect(page).to have_content "10 techniques"
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

  scenario 'user destroys a study' do
    study = create :study, techniques_count: 1

    sign_in study.user
    click_link "Studies"
    click_link study.name
    click_link "Delete"

    expect(page).to have_content "Study deleted"
    expect(page).not_to have_content study.name
  end
end
