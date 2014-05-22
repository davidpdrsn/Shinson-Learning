require "spec_helper"

feature "inline editing of techniques" do
  scenario "a user edits a technique inline", js: true do
    sign_up
    create_technique build(:technique, description: "Ruby lol")
    visit root_path
    click_link "Techniques"
    click_link "Peek all"
    click_link "Edit"
    fill_in "rest-in-place-description", with: "Hi there"
    click_link "Peek all"

    expect(page).to have_content "Hi there"
  end
end
