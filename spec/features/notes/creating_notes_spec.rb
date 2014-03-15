require 'spec_helper'

feature "adding notes to techniques" do
  scenario "a user adds a note to one of his techniques" do
    sign_up
    create_technique
    fill_in "Note text", with: "Text of the new note"
    click_button "Create Note"

    expect(page).to have_content "Text of the new note"
  end

  scenario "a user creates an invalid note, then fixes it" do
    sign_up
    create_technique
    fill_in "Note text", with: ""
    click_button "Create Note"
    fill_in "Note text", with: "Text of the note"
    click_button "Create Note"

    expect(page).to have_content "Text of the note"
  end
end

