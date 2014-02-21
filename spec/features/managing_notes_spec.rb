require 'spec_helper'

feature "adding a note to a technique" do
  scenario "a user adds a note to one of his techniques" do
    sign_up
    create_technique
    fill_in "Note text", with: "Text of the new note"
    click_button "Create Note"

    expect(page).to have_content "Text of the new note"
  end
end
