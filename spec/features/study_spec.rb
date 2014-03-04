require 'spec_helper'

feature "study" do
  scenario "user creates a new study" do
    bob = create :user
    kicks = create :category
    white = create :belt
    4.times { create :technique, user: bob, category: kicks, belt: white }

    sign_in bob

    click_link "New study"
    select white.pretty_print, from: "Belt"
    select kicks.name, from: "Category"
    click_button "Create Study"

    expect(page).to have_content "4 techniques"
  end

  scenario "user views a study" do
    study = create :study

    sign_in study.user
    click_link "Studies"
    click_link study.pretty_print

    expect(page).to have_content study.pretty_print
    expect(page).to have_content "#{study.techniques.count} techniques"
  end
end
