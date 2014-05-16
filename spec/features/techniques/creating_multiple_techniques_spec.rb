require 'spec_helper'

feature 'creating multiple techniques' do
  scenario 'a user creates multiple techniques', js: true do
    belt = create :belt
    category = create :category

    sign_up
    click_link "Techniques"
    click_link "Add multiple"

    within "fieldset:first-of-type" do
      fill_in "techniques[name][]", with: "one"
      fill_in "techniques[description][]", with: "Description"
      select belt.pretty_print, from: "techniques[belt_id][]"
      select category.name, from: "techniques[category_id][]"
    end

    click_button "+"

    within "fieldset:last-of-type" do
      fill_in "techniques[name][]", with: "two"
      fill_in "techniques[description][]", with: "Description"
      select belt.pretty_print, from: "techniques[belt_id][]"
      select category.name, from: "techniques[category_id][]"
    end

    click_button "Save Techniques"

    click_link "Peek all"

    expect(page).to have_content "Techniques saved"
    expect(page).to have_content "one"
    expect(page).to have_content "two"
  end
end
