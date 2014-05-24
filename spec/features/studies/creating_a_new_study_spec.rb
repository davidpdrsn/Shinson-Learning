require 'spec_helper'

feature 'a user creates a new study' do
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
    click_link "Add new"
    fill_in "Name of study", with: "Misc study"
    fill_in "new-study__query", with: "tec"
    click_link "technique #1"
    click_link "technique #3"
    click_link "technique #2"
    click_link "technique #9"
    click_button "Create Study"

    expect(page).to have_content "Misc study"
    expect(page).to have_content "4"
  end

  scenario "user tries to find techniques that don't exist", js: true do
    sign_in bob

    click_link "Studies"
    click_link "Add new"
    fill_in "Name of study", with: "Misc study"
    fill_in "new-study__query", with: "tec"

    expect(page).to have_content "No matches were found"
  end

  scenario "user searches for techniques and adds all the matches", js: true do
    10.times do |n|
      create :technique, user: bob, belt: white, category: kicks, name: "technique ##{n}"
    end

    sign_in bob

    click_link "Studies"
    click_link "Add new"
    fill_in "Name of study", with: "Misc study"
    fill_in "new-study__query", with: "tec"
    click_button "Add all"
    click_button "Create Study"

    expect(page).to have_content "10"
  end

end
